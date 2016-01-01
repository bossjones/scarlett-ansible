require 'serverspec'

set :backend, :exec

# RSpec.configure do |config|
#   config.expect_with :rspec do |c|
#     c.syntax = :expect
#   end
# end

begin
  Gem::Specification.find_by_name('yaml')
rescue Gem::LoadError
  require 'rubygems/dependency_installer'
  Gem::DependencyInstaller.new(Gem::DependencyInstaller::DEFAULT_OPTIONS).install('yaml')
end
