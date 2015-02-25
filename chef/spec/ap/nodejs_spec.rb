require 'spec_helper'

describe "nodejs spec" do
  # package
  describe package('nodejs') do
    it { should be_installed }
  end
end
