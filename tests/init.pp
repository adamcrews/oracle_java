# The baseline for module testing used by Puppet Labs is that each manifest
# should have a corresponding test manifest that declares that class or defined
# type.
#
# Tests are then run by using puppet apply --noop (to check for compilation
# errors and view a log of events) or by fully applying the test in a virtual
# environment (to compare the resulting system state to the desired state).
#
# Learn more about module testing here:
# http://docs.puppetlabs.com/guides/tests_smoke.html
#
include ::oracle_java

# install the jre
oracle_java::install { [ '8u40', '7u80' ]: }

# install the jdk
oracle_java::install { [ '7u79', '8u45' ]:
  java_type => 'jdk',
}
