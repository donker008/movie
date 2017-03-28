class ReviewsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy, :favoriteIt]

  def index
    @reviews = Review.all.order("updated_at desc")
    @movie = Movie.find(params[:movie_id])
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
    @review.movie = Movie.find(params[:movie_id])
  end

  def create
    @review = Review.new(review_params)
    @review.movie = Movie.find(params[:movie_id])
    @review.user = current_user
    if @review.save
      flash[:notice] = "Review successful!"
      redirect_to movie_reviews_path
    else
      flash[:error] = "Review failed!"
      render :new
    end

  end

  def destroy

  end

  

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
