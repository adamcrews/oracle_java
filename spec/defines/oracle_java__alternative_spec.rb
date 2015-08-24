#!/usr/bin/env ruby

require 'spec_helper'

describe 'oracle_java::alternative' do
  context 'supported operating systems' do
    on_supported_os({:hardwaremodels => [ 'i386', 'x86_64']}).each do |os, facts|
      context "on #{os} with puppet v#{Puppet.version}" do
        let (:facts) do
          facts
        end

        let (:title) { '7u40' }

        let (:default_params) {{
          :java_dir  => '/usr/java',
          :java_type => 'jre',
        }}


        context "missing required arguments" do
          it {is_expected.to compile.and_raise_error(/must pass/i)}
        end

        ['6', '7a12', 'foo', '7u'].each do |t|
          context "invalid java version #{t}" do
            let (:title) {t}
            let (:params) do
              default_params
            end
            it {is_expected.to compile.and_raise_error(/or formatted as/i)}
          end
        end

        context "invalid java_dir" do
          let (:params) do
            default_params.merge({
              :java_dir => 'relative/path',
            })
          end
          it {is_expected.to compile.and_raise_error(/absolute path/i)}
        end

        context "invalid java_type" do
          let (:params) do
            default_params.merge({
              :java_type => 'foo',
            })
          end
          it {is_expected.to compile.and_raise_error(/must be 'jdk' or 'jre'/i)}
        end

        [ 'abc', '199999' ].each do |p|
          context "invalid priority #{p}" do
            let (:params) do
              default_params.merge({
                :priority => p
                })
            end
            it {is_expected.to compile.and_raise_error(/expected/i)}
          end
        end

        context "with default params" do
          let (:params) do
            default_params
          end
          it { is_expected.to contain_exec("Alternatives for #{title}").with(
            'command' => /java 17040/,
            )
          }
        end

        context "with alternate priority" do
          let(:params) do
            default_params.merge({
              :priority => 10
              })
          end
          it { is_expected.to contain_exec("Alternatives for #{title}").with(
            'command' => /java 10 /
          )}
        end
      end
    end
  end
end
