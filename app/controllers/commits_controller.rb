class CommitsController < ApplicationController
  def index
    @commits = []
    @keyword = ""
  end

  def search
    @keyword = params[:keyword]
    @commits = Commit.search_message(@keyword).paginate(page: params[:page])
  end
end
