#! /usr/bin/env ruby

require 'spec_helper'

describe "get_java_info" do
  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params().and_raise_error(Puppet::ParseError, /wrong number of arguments/i) }
  it { is_expected.to run.with_params('1', '2').and_raise_error(Puppet::ParseError, /wrong number of arguments/i) }
  it { is_expected.to run.with_params('6').and_raise_error(Puppet::ParseError, /are supported/i)}
  it { is_expected.to run.with_params('8u51').and_return(['8', '51', '-b16']) }
  it { is_expected.to run.with_params('7').and_return(['7', '', '']) }
end
