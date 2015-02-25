require 'spec_helper'

describe "git spec" do
  # package
  describe package('git') do
    it { should be_installed }
  end
end
