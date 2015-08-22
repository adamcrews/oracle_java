#!/usr/bin/env ruby

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

        it { is_expected.to contain_file("/usr/java") }
        it { is_expected.to contain_file("/usr/java/.dl_cache") }
        it { is_expected.to contain_archive("/usr/java/.dl_cache/jre-#{title}-linux-#{arch}.tar.gz") }
        it { is_expected.to contain_oracle_java__alternative(title) }

        [ '6', '7a12', 'foo', '7u' ].each do |t|
          context "invalid java version #{t}" do
            let (:title) { t }
            it { is_expected.to compile.and_raise_error(/or formatted as/i) }
          end
        end

        [ '8u51', '7u40'].each do |t|
          context "valid java version #{t}" do
            let (:title) { t }
            it { is_expected.to compile }
            it { is_expected.to contain_oracle_java__install(title) }
            it { is_expected.to contain_oracle_java__alternative(title) }

            [ 'jdk', 'jre' ].each do |j|
              context "valid java_type #{j}" do
                let (:params) {{ :java_type => j }}
                it { is_expected.to compile }
                it { is_expected.to contain_archive("/usr/java/.dl_cache/#{j}-#{title}-linux-#{arch}.tar.gz") }
              end
            end

            context "valid java_dir" do
              let(:params) {{ :java_dir => '/home/java' }}
              it { is_expected.to contain_file('/home/java').with_ensure('directory') }
              it { is_expected.to contain_file('/home/java/.dl_cache').with_ensure('directory') }
              it { is_expected.to contain_archive("/home/java/.dl_cache/jre-#{title}-linux-#{arch}.tar.gz") }
            end

            context 'alternatives set to false' do
              let(:params) {{ :alternatives => false }}
              it { is_expected.not_to contain_oracle_java__alternative(title) }
            end
          end
        end

        context "invalid java_dir" do
          let (:params) {{ :java_dir => 'relative/path' }}
          it { is_expected.to compile.and_raise_error(/absolute path/i)}
        end

        context "invalid arch" do
          let (:params) {{ :arch => 'foo' }}
          it { is_expected.to compile.and_raise_error(/arch \(foo\)/i) }
        end

        context "invalid java_type" do
          let (:params) {{ :java_type => 'java' }}
          it { is_expected.to compile.and_raise_error(/must be 'jdk' or 'jre'/i) }
        end
      end
    end
  end
end
