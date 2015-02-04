class CommitsController < ApplicationController
  def index
    @commits = []
  end

  def search
    @commits = Commit.paginate(page: params[:page])
  end
end
