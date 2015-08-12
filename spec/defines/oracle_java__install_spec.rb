require 'spec_helper'

describe 'oracle_java::install' do
  context 'supported operating systems' do
    on_supported_os({:hardwaremodels => [ 'i386', 'x86_64']}).each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        let (:title) { '7u40' }
        arch = case facts[:architecture]
          when /^i(\d+)/
            'i586'
          else
            'x64'
        end

        it { should contain_file("/usr/java") }
        it { should contain_file("/usr/java/.dl_cache") }
        it { should contain_archive("/usr/java/.dl_cache/jre-#{title}-linux-#{arch}.tar.gz") }

        [ '6', '7a12', 'foo', '7u' ].each do |t|
          context "invalid java version #{t}" do
            let (:title) { t }
            it { should_not compile }
          end
        end

        [ '8u51', '7u40'].each do |t|
          context "valid java version #{t}" do
            let (:title) { t }
            it { should compile }
            it { should contain_oracle_java__install(t) }
            it { should contain_archive("/usr/java/.dl_cache/jre-#{title}-linux-#{arch}.tar.gz") }
          end
        end

        context "invalid java_dir" do
          let (:params) {{ :java_dir => 'relative/path' }}
          it { should_not compile }
        end

        context "valid java_dir" do
          let(:params) {{ :java_dir => '/home/java' }}
          it { should contain_file('/home/java').with_ensure('directory') }
          it { should contain_file('/home/java/.dl_cache').with_ensure('directory') }
          it { should contain_archive("/home/java/.dl_cache/jre-#{title}-linux-#{arch}.tar.gz") }
        end

        context "invalid arch" do
          let (:params) {{ :arch => 'foo' }}
          it { should_not compile }
        end

        context "invalid java_type" do
          let (:params) {{ :java_type => 'java' }}
          it { should_not compile }
        end

        context "valid java_type [jre|jdk])" do
          [ 'jdk', 'jre' ].each do |j|
            let (:params) {{ :java_type => j }}
            it { should compile }
          end
        end
      end
    end
  end
end

