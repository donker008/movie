class Account::ReviewsController < ApplicationController

  before_action :authenticate_user!, only:[:index, :destroy]

  def index
      @reviews = Review.where(user_id: current_user.id).paginate(:page => params[:page], :per_page => 5)
  end

  def destroy
    review = Review.find(params[:id])
    if review
        @movie = Movie.find(review.movie.id)
        @movie.decrement(:review_count, 1)
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
