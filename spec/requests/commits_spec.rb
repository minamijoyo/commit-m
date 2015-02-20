require 'rails_helper'

RSpec.describe "Commits", type: :request do
  subject { page }

  describe "Root Page" do
    before { visit root_path }

    describe "Site name" do
      it { should have_content('commit-m') }
      it { should have_title('commit-m') }
    end

    describe "Twitter link" do
      it { should have_link("@minamijoyo", href:  "https://twitter.com/minamijoyo")}
    end

    describe "Search form" do
#      let!(:commit1) { FactoryGirl.create(:commit, message: "hoge hoge") }
#      let!(:commit2) { FactoryGirl.create(:commit, message: "hoge fuga") }
#      let!(:commit3) { FactoryGirl.create(:commit, message: "fuga fuga") }

      before{
        3.times { FactoryGirl.create(:commit) }
        fill_in "keyword", with:"Message"
        click_button "Search"
      }
      after { Commit.delete_all }

      it { should have_content('3 results.') }

    end
  end

  describe "Search Page" do
    describe "Search" do
      before {
        31.times { FactoryGirl.create(:commit) }
        visit commits_search_path
        fill_in "keyword", with:"Message"
        click_button "Search"
      }
      after { Commit.delete_all }
      it { should have_content('31 results.') }
      it { should have_selector('table') }
      it { should have_content('Message') }
      it { should have_selector('div.pagination') }

      describe "Pagination" do
        before { all('.pagination')[1].click_link('2') }
        it { should have_content('Message') }
      end
    end
  end

end
