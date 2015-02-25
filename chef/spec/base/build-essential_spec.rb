require 'spec_helper'

# package
packages = %w{
                autoconf
                bison
                flex
                gcc
                gcc-c++
                kernel-devel
                make
                m4
                patch
              }

packages.each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end
