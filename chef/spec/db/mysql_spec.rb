require 'spec_helper'

describe "mysql spec" do
  # mysql command
  describe command('which mysql') do
    let(:disable_sudo) { true }
    its(:exit_status) { should eq 0 }
  end

  # package
  describe package('mysql-community-server') do
    it { should be_installed.with_version("5.6") }
  end

  # service
  describe service('mysqld') do
    it { should be_enabled }
    it { should be_running }
  end

  # port
  describe port("3306") do
    it { should be_listening }
  end
end
