# == Class oracle_java::params
#
# This class is meant to be called from oracle_java.
# It sets variables according to platform.
#
class oracle_java::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'oracle_java'
      $service_name = 'oracle_java'
    }
    'RedHat', 'Amazon': {
      $package_name = 'oracle_java'
      $service_name = 'oracle_java'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
