class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
    @movie = Movie.find(params[:movie_id])
  end

end
