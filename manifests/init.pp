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
  $java_type      = 'jre',
  $java_versions  = [ '8u51' ],
  $java_dir       = '/usr/java',
) inherits ::oracle_java::params {

  # validate parameters here
  validate_re($java_type, '^(jdk|jre)$', "\$java_type (${java_type}) must be 'jdk' or 'jre'")

  oracle_java::install { $java_versions:
    java_type => $java_type,
  }

}
