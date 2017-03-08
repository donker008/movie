class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(post_params)
    @group.save
    redirect_to groups_path
  end

 private
 def post_params
   params.require(:group).permit(:title,:description)
 end
end
