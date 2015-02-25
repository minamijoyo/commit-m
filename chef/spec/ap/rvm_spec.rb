require 'spec_helper'

describe "rvm spec" do
  # rvm install
  describe command('which rvm') do
    let(:disable_sudo) { true }
    its(:exit_status) { should eq 0 }
  end

  # ruby versions
  describe command('ruby -v') do
    let(:disable_sudo) { true }
    its(:stdout) { should match /ruby 2\.2\.0p0.+/ }
  end
end
