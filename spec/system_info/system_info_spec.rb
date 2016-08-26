#!/usr/bin/env ruby

require 'spec_helper'

describe "BOSSSSSS JONESSSSS #{os[:release]} #{os[:family]} #{os[:arch]} #{os[:release].to_i}" do
  it 'installs python' do
    expect(package('python')).to be_installed
  end
end
