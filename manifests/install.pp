define oracle_java::install (
  $java_dir     = '/usr/java',
  $download_url = 'http://download.oracle.com/otn-pub/java/jdk',
  $java_type    = 'jre',
  $arch         = $::architecture,
  $alternatives = true,
) {

  # let's use the title as the java version
  $version = $title

  validate_absolute_path($java_dir)
  validate_string($download_url)
  validate_re($version, '^([78]|[78]u[0-9]{1,2})$', "\$version (${version}) should be <major_ver> or formatted as <major_ver>u<minor>")
  validate_re($java_type, '^(jdk|jre)$', "\$java_type (${java_type}) must be 'jdk' or 'jre'")
  validate_re($arch, '^(i386|x86|x86_64|amd64)$', "\$arch (${arch}) must be i386, x86, x86_64, or amd64")

  # what java architecture to install
  $_arch = $arch ? {
    /x86_64|amd64/ => 'x64',
    default        => 'i586',
  }

  # Code below liberally stolen from https://github.com/antoineco/aco-oracle_java
  # get major/minor version numbers
  $array_version  = get_java_info($version)
  $maj_version    = $array_version[0]
  $min_version    = $array_version[1]
  $_build         = $array_version[2]

  # remove extra particle if minor version is 0
  $version_final = delete($version, 'u0')
  $longversion = $min_version ? {
    '0'       => "${java_type}1.${maj_version}.0",
    /^[0-9]$/ => "${java_type}1.${maj_version}.0_0${min_version}",
    default   => "${java_type}1.${maj_version}.0_${min_version}"
  }

  # Build up our download url
  $filename = "${java_type}-${version_final}-linux-${_arch}.tar.gz"

  case $download_url {
    /download.oracle.com/ : {
      $_url = "${download_url}/${version}${_build}/${filename}"
    }
    default : {
      $_url = "${download_url}/${filename}"
    }
  }

  if ! defined(File[$java_dir]) {
    file { $java_dir:
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0755',
    }
  }

  if ! defined(File["${java_dir}/.dl_cache"]) {
    file { "${java_dir}/.dl_cache":
      ensure => directory,
      owner  => root,
      group  => root,
      mode   => '0750',
    }
  }

  # Finally, let's do something real and get the file
  include ::archive

  # We set the tar options to add the 'o' so that the group/owner
  # info is dropped and everything is just installed as whatever user
  # this profile runs as (usually root)
  archive { "${java_dir}/.dl_cache/${filename}":
    cookie        => 'oraclelicense=accept-securebackup-cookie',
    source        => $_url,
    cleanup       => true,
    extract       => true,
    extract_path  => $java_dir,
    extract_flags => {'tar' => 'xof' },
    creates       => "${java_dir}/${longversion}",
    require       => File["${java_dir}/.dl_cache"],
  }

  if $alternatives == true {
    oracle_java::alternative { $version:
      java_dir  => $java_dir,
      java_type => $java_type,
    }
  }
}
