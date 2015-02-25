require 'spec_helper'

describe "sqlite spec" do
  # package
  describe package('sqlite') do
    it { should be_installed }
  end
end
