# Class: oracle_java
# ===========================
#
# This class will handle installing the oracle JDK or JRE.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class oracle_java (
  $package_name = $::oracle_java::params::package_name,
  $service_name = $::oracle_java::params::service_name,
) inherits ::oracle_java::params {

  # validate parameters here

}
