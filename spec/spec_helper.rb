# require 'serverspec'

# set :backend, :exec

require 'serverspec'
require 'net/ssh'
require 'tempfile'

set :backend, :ssh

host = ENV['TARGET_HOST']

`VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant up #{host}`

config = Tempfile.new('', Dir.tmpdir)
`VAGRANT_VAGRANTFILE=Vagrantfile-ansible-test vagrant ssh-config #{host} > #{config.path}`

options = Net::SSH::Config.for(host, [config.path])

options[:user] ||= Etc.getlogin

set :host,        options[:host_name] || host
set :ssh_options, options


RSpec.configure do |c|
  c.around :each, sudo: false do |example|
    set :disable_sudo, true
    example.run
    set :disable_sudo, false
  end
end
