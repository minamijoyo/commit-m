require 'spec_helper'

# package
describe package('git') do
  it { should be_installed }
end
