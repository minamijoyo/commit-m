require 'spec_helper'

# package
describe package('nodejs') do
  it { should be_installed }
end
