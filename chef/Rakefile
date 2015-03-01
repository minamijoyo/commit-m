require 'rake'
require 'rspec/core/rake_task'
require 'json'
require 'erb'
hosts = JSON.parse(ERB.new(File.read('hosts.json')).result)

desc "Run serverspec to all hosts"
task :serverspec => 'serverspec:all'

namespace :serverspec do
  task :all => hosts.map { |host| 'serverspec:' + host['name'] }
  hosts.each do |host|
    desc "Run serverspec to #{host['name']}"
    RSpec::Core::RakeTask.new(host['name'].to_sym) do |t|
      ENV['TARGET_HOST'] = host['name']
      t.pattern = 'spec/{' + host['roles'].join(',') + '}/*_spec.rb'
    end
  end
end
