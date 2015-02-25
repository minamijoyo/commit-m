require 'spec_helper'

# package
describe package('sqlite') do
  it { should be_installed }
end
