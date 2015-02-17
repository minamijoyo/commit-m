require 'rails_helper'

describe "Commits", type: :request do
  describe "Index Page" do
    it "should have the content commit-m" do
      visit '/'
      expect(page).to have_content('commit-m')
    end
  end
end
