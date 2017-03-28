class ReviewsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :destroy, :favoriteIt]

  def index
    @reviews = Review.where(movie_id:params[:movie_id])
    @movie = Movie.find(params[:movie_id])

    mv =  Movie.find(params[:movie_id])
    mv.increment(:view_count, 1)
    mv.save

    # @movie.increment(:view_count, 1)
    # @movie.save
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @review = Review.new
    @review.movie = Movie.find(params[:movie_id])
  end

  def create
    @review = Review.new(review_params)
    @review.movie =Movie.find(params[:movie_id])
    @review.user = current_user

    if @review.save

      @mv =  Movie.find(params[:movie_id])
      @mv.increment(:review_count, 1)
      @mv.save

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
