require 'serverspec'
require 'net/ssh'
require 'yaml'
require 'erb'
hosts = YAML.load(ERB.new(File.read('hosts.yml')).result)

set :backend, :ssh

if ENV['ASK_SUDO_PASSWORD']
  begin
    require 'highline/import'
  rescue LoadError
    fail "highline is not available. Try installing it."
  end
  set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
else
  set :sudo_password, ENV['SUDO_PASSWORD']
end

h = ENV['TARGET_HOST']
set :host,        hosts[h][:host_name]
set :ssh_options, {
  :user => hosts[h][:user],
  :port => hosts[h][:port],
  :keys => hosts[h][:keys],
}

set :request_pty, true

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
