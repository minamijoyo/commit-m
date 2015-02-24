require 'spec_helper'

# ruby versions
describe command('ruby -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /ruby 2\.2\.0p0.+/ }
end
