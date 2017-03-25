class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update]

    def index

      sort = params[:sort]
      if sort == "hot"
        @movies = Movie.all.order("view_count desc")
      elsif sort == "review"
        @movies = Movie.all.order("review_count desc")
      elsif sort == "time"
        @movies = Movie.all.order("created_at desc")
      end

      cate_id = params[:category_id]
      if (nil != cate_id && -1 != cate_id.to_i)
        cate = Category.find(cate_id)
        @movies = Movie.where(category_id:cate_id)
      else
        @movies = Movie.all.order("created_at desc")
      end

      if nil == @movies || 0 == @movies.size
        @movies = Movie.all
      end

      @hotMovie = @movies.first
      @categories = Category.all

    end

    def new
      @movie = Movie.new
      # @categories = Category.all
    end

    def create

      category_object = Category.find(category_params[:id])
      # render plain: params[:movie].inspect + params[:category].inspect

      if category_object

        @movie = Movie.new(movie_params)
        @movie.category = category_object
        @movie.user = current_user
        if @movie.save
            flash[:notice] = "Create movie successful!"
            redirect_to movies_path
        else
            flash[:notice] = "Create movie failed!"
            render :new
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
      params.require(:movie).permit(:title, :brief, :cover_url)
    end

    def category_params
      params.require(:category).permit(:id)
    end

end
