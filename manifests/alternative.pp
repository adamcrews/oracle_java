define oracle_java::alternative (
  $java_dir,
  $java_type,
  $priority = 'default',
) {

  $version = $title

  # Validate values here
  validate_absolute_path($java_dir)
  validate_re($version, '^([78]|[78]u[0-9]{1,2})$', "\$version (${version}) should be <major_ver> or formatted as <major_ver>u<minor>")
  validate_re($java_type, '^(jdk|jre)$', "\$java_type (${java_type}) must be 'jdk' or 'jre'")

  $_v = get_java_info($version)
  $_major = $_v[0]
  $_minor = $_v[1]

  if $priority == 'default' {
    $_real_priority = 10000 + ($_major * 1000) + ($_minor * 1)
  } else {
    validate_integer($priority, 99999, 0)
    $_real_priority = $priority
  }

  $java_name = $_minor ? {
    '0'       => "${java_type}1.${_major}.0",
    /^[0-9]$/ => "${java_type}1.${_major}.0_0${_minor}",
    default   => "${java_type}1.${_major}.0_${_minor}"
  }

  # here we define the bin files and man files that are linked with the
  # alternatives command. I'm lazy so I'm over-linking.  If you install the jre
  # or older versions of java, this will have too many commands and man pages
  # but there is no real impact to having extra alternatives links.
  $bin_files = [
    'appletviewer', 'ControlPanel', 'extcheck', 'idlj', 'jar', 'jarsigner',
    'javac', 'javadoc', 'javafxpackager', 'javah', 'javap', 'javapackager',
    'javaws', 'jcmd', 'jconsole', 'jcontrol', 'jdb', 'jdeps', 'jhat', 'jinfo',
    'jjs', 'jmap', 'jmc', 'jps', 'jrunscript', 'jsadebugd', 'jstack', 'jstat',
    'jstatd', 'jvisualvm', 'keytool', 'native2ascii', 'orbd', 'pack200',
    'policytool', 'rmic', 'rmid', 'rmiregistry', 'schemagen', 'serialver',
    'servertool', 'tnameserv', 'unpack200', 'wsgen', 'wsimport', 'xjc',
  ]

  # This template uses $java_home, $java_name, $_real_priority and $bin_files
  exec { "Alternatives for ${version}":
    command => template("${module_name}/alternatives.erb"),
    path    => [ '/usr/bin', '/usr/sbin', '/bin' ],
    unless  => "alternatives --display java | grep -q \"${java_home}/${java_name}/bin/java - priority ${priority}\""
  }

}
