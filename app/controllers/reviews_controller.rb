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

  def favoriteIt

    @movie = Movie.find(params[:movie_id])
    if @movie

      @favorite = Favorite.new
      @favorite.user = current_user
      @favorite.movie = @movie
      if @favorite.save
        flash[:notice] = "Favorite successful!";
        redirect_to movie_reviews_path
      else
        flash[:error] = "Favorite movie failed!";
        redirect_to movie_reviews_path
      end
    else
      flash[:error] = "Movies dont exist!";
      redirect_to movie_reviews_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
