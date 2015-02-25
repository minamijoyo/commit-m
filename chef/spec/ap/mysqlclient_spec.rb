require 'spec_helper'

describe "mysqlclient spec" do
  # mysql command
  describe command('which mysql') do
    let(:disable_sudo) { true }
    its(:exit_status) { should eq 0 }
  end
end
