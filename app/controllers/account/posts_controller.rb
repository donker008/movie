class Account::PostsController < ApplicationController
  def index
    @posts = current_user.posts
  end



  private

  def post_params
    params.require(:post).permit(:content)
  end
end
