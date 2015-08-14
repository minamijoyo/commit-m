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

    describe "Search form", :elasticsearch do
      before do
        3.times { FactoryGirl.create(:commit) }

        Commit.__elasticsearch__.create_index! force: true
        Commit.__elasticsearch__.refresh_index!
        Commit.import
        sleep 1
      end

      after do
        Commit.__elasticsearch__.client.indices.delete index: Commit.index_name
        Commit.delete_all
      end

      describe 'Click Search button' do
        before do
          fill_in "keyword", with:"Message"
          click_button "Search"
        end
        it { should have_content('3 results.') }
      end

    end
  end

  describe "Search Page", :elasticsearch do
    before do
      31.times { FactoryGirl.create(:commit) }

      Commit.__elasticsearch__.create_index! force: true
      Commit.__elasticsearch__.refresh_index!
      Commit.import
      sleep 1
    end

    after do
      Commit.__elasticsearch__.client.indices.delete index: Commit.index_name
      Commit.delete_all
    end

    describe "Search" do
      before do
        visit commits_search_path
        fill_in "keyword", with:"Message"
        click_button "Search"
      end
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
