require 'spec_helper'

# package
describe package('mysql-community-client') do
  it { should be_installed }
end
