require 'serverspec'
require 'net/ssh'
require 'json'
require 'erb'
hosts = JSON.parse(ERB.new(File.read('hosts.json')).result)

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

host = hosts.find{ |h| h['name'] == ENV['TARGET_HOST'] }
set :host,        host['host_name']
set :ssh_options, {
  :user => host['user'],
  :port => host['port'],
  :keys => host['keys']
}

set :request_pty, true

# Disable sudo
# set :disable_sudo, true


# Set environment variables
# set :env, :LANG => 'C', :LC_MESSAGES => 'C'

# Set PATH
# set :path, '/sbin:/usr/local/sbin:$PATH'
