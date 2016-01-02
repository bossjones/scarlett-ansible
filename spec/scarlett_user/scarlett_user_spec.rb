#!/usr/bin/env ruby

require 'spec_helper'

describe 'scarlett linux user pi' do

  it 'creates pi user with following properties' do
    expect(user('pi')).to exist
    expect(user('pi')).to have_uid(1000)
    expect(user('pi')).to have_home_directory('/home/pi')
    expect(user('pi')).to have_login_shell('/bin/bash')
  end # it create pi user

end # describe

describe 'scarlett linux user pi belongs to these groups' do

  %w(adm cdrom sudo dip plugdev lpadmin sambashare pulse pulse-access tty audio vboxusers).each do |pkg|

    it "belongs to group #{pkg}" do
      expect(user('pi')).to belong_to_group("#{pkg}")
    end # belongs to group

  end # %w

end # describe
