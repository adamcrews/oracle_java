#!/usr/bin/env ruby

require 'spec_helper'

describe 'oracle_java' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os} with puppet v#{Puppet.version}" do
        let(:facts) do
          facts
        end

        context "oracle_java class without any parameters" do
          let(:params) {{ }}

          latest_ver = '8u60'

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('oracle_java')}
          it { is_expected.to contain_class('oracle_java::params') }
          it { is_expected.to contain_oracle_java__install(latest_ver).with(:java_type => 'jre')}
          it { is_expected.to contain_archive("/usr/java/.dl_cache/jre-#{latest_ver}-linux-x64.tar.gz")}
          it { is_expected.to contain_oracle_java__alternative(latest_ver)}
          #it { is_expected.to contain_oracle_java__install('8u60').with(:java_type => 'jre') }
           #.that_comes_before('oracle_java::config') }
          #it { is_expected.to contain_class('oracle_java::config') }
          #it { is_expected.to contain_class('oracle_java::service').that_subscribes_to('oracle_java::config') }

          #it { is_expected.to contain_service('oracle_java') }
          #it { is_expected.to contain_package('oracle_java').with_ensure('present') }
        end
      end
    end
  end

#  context 'unsupported operating system' do
#    describe 'oracle_java class without any parameters on Solaris/Nexenta' do
#      let(:facts) {{
#        :osfamily        => 'Solaris',
#        :operatingsystem => 'Nexenta',
#      }}
#
#      it { expect { is_expected.to contain_package('oracle_java') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
#    end
#  end
end
