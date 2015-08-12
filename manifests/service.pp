# == Class oracle_java::service
#
# This class is meant to be called from oracle_java.
# It ensure the service is running.
#
class oracle_java::service {

  service { $::oracle_java::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
