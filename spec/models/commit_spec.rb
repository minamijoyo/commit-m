require 'rails_helper'

RSpec.describe Commit, type: :model do
  before { @commit = Commit.new(
    repo_full_name: 'minamijoyo/commit-m',
    sha: 'ad029c9d6d79ad6e1b2ca4ff33e998c23c471675',
    message: 'Initial commit') }

  subject { @commit }

  it { should respond_to(:repo_full_name) }
  it { should respond_to(:sha) }
  it { should respond_to(:message) }

  it { should be_valid }
  
end
