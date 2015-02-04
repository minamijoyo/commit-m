class CommitsController < ApplicationController
  def index
    @commits = []
  end

  def search
    keyword = params[:keyword]
    @commits = Commit.search(:message_cont => keyword).result.paginate(page: params[:page])
  end
end
