require 'spec_helper'

# mysql command
describe command('which mysql') do
  let(:disable_sudo) { true }
  its(:exit_status) { should eq 0 }
end
