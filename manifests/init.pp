# Class: oracle_java
# ==================
#
# This class install the latest Java from Oracle.  Use of this class is
# NOT required. You may use the defines to acomplish the same thing, but in a
# more flexible way.
#
# Parameters
# ----------
#
# * `java_type`
#   Choose to install the JDK or just the JRE distribution of Oracle Java.
#
# * `java_versions`
#   An array of java versions to install.  Note: passing multiple java versions
#   works well, but you may not mix jdk/jre with this class.  If you wish to
#   install both a jdk and jre, you should use oracle_java::install
#
class oracle_java (
  $java_type      = 'jre',
  $java_versions  = [ '8u60' ],
) inherits ::oracle_java::params {

  oracle_java::install { $java_versions:
    java_type => $java_type,
  }

}
