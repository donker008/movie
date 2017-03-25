class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update]

    def index
      @movies = Movie.all
      @hotMovie = @movies.first
      @categories = Category.all
    end

    def new
      @movie = Movie.new
      # @categories = Category.all
    end

    def create

      category_object = Category.where(title:movie_params[:category_id]).first
      if category_object
        my_params = movie_params
        my_params[:category] = category_object
        @move = Movie.new(my_params)
        if @move.save
            flash[:notice] = "Upload successful!"
            redirect_to movies_path
        else
            flash[:notice] = "Upload failed!"
        end

      end

    end

    def  update

    end

    def show

    end

    def destroy

    end


    private

    def movie_params
      params.require(:movie).permit(:title, :brief, :cover_url, :category);
    end

end
