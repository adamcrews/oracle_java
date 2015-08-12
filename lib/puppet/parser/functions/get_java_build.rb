module Puppet::Parser::Functions
  newfunction(:get_java_build, :type => :rvalue, :doc => <<-EOS
    Get the build number used by oracle in their java download url.
    EOS
  ) do |args|

  # This whole function is really offensive, but I've not found a better
  # way to handle the fact that oracle embeds a build number in the
  # download url.  This function will require updating with every 
  # java release
  # The only alternative I can think of would be to web scrape the oracle
  # website for the download url at the time of download, but that seems
  # rather un-kind to do for every host for every download.

  raise(Puppet::ParseError, "get_java_build(): Wrong number of arguments given #{args.size} (should be 1)") unless args.size == 1

  java_ver = args[0]

  # man this is ugly...
  java_build = {
    :"8u51" => '-b16',
    :"8u45" => '-b14',
    :"8u40" => '-b25',
    :"8u31" => '-b13',
    :"8u25" => '-b17',
    :"8u20" => '-b26',
    :"8u11" => '-b12',
    :"8u5"  => '-b13',
    :"8"    => '-b132',

    :"7u80" => '-b15',
    :"7u79" => '-b15',
    :"7u76" => '-b13',
    :"7u75" => '-b13',
    :"7u72" => '-b14',
    :"7u71" => '-b14',
    :"7u67" => '-b01',
    :"7u65" => '-b17',
    :"7u60" => '-b19',
    :"7u55" => '-b13',
    :"7u51" => '-b13',
    :"7u45" => '-b18',
    :"7u40" => '-b43',
    :"7u25" => '-b15',
    :"7u21" => '-b11',
    :"7u17" => '-b02',
    :"7u15" => '-b03',
    :"7u13" => '-b20',
    :"7u11" => '-b21',
    :"7u10" => '-b18',
    :"7u9"  => '-b05',
    :"7u7"  => '-b10',
    :"7u6"  => '-b24',
    :"7u5"  => '-b06',
    :"7u4"  => '-b20',
    :"7u3"  => '-b04',
    :"7u2"  => '-b13',
    :"7u1"  => '-b08',
    :"7"    => '',
  }

  return java_build[:"#{java_ver}"]

  end
end
