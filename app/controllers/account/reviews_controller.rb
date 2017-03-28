class Account::ReviewsController < ApplicationController

  before_action :authenticate_user!, only:[:index, :destroy]

  def index
      @reviews = Review.where(user_id: current_user.id)
  end

  def destroy
    review = Review.find(params[:id])
    if review
      if review.delete
        if review.user == current_user
          flash[:notice] = "Delete review successful!"
        else
          flash[:notice] = "Cant delete other people's review !";
        end

      else
        flash[:error] = "Delete review failed!"
      end

    else
      flash[:error] = "Cant find review!"
    end
    redirect_to account_reviews_path
  end

end
