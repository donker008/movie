class PostsController < ApplicationController

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user
    if  @post.save
      flash[:notice] =  "Post Created!"
      redirect_to group_path(@group)
    else
      render :new
    end

  end

  def edit
    @post = Post.find(params[:id])
    @group = Group.find(params[:group_id])
    if !current_user || current_user != @post.user
      flash[:warning] = "You'r not the creator of post, you cant edit it!"
      render :index
    end
  end

  def update
    @post = Post.find(params[:id])
    if current_user && current_user = @post.user
        if @post.update(post_params)
          flash[:notice] = "Update post success!"
        else
          flash[:alert] = "Update post failed!"
        end
    else
      flash[:warning] = "You'r not the creator of post, you cant edit it!"
    end
    redirect_to account_posts_path
  end

  def destroy

    @post = Post.find(params[:id])
    if current_user &&  @post.user == current_user
      @post.destroy
      flash[:notice] = "Post deleted!"
    else
      flash[:alert] = "You are not the creator of post, you cant delete it!"
    end
      redirect_to account_posts_path
  end

  private
  def post_params
    params.require(:post).permit(:content)
  end
end
