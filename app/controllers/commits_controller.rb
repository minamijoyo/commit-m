class CommitsController < ApplicationController
  def index
    @commits = Commit.paginate(page: params[:page])
  end
end
