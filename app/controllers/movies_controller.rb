class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :update, :favoriteIt]

    def index

      sort = params[:sort]
      cate_id = params[:category_id]
      if (nil != cate_id && -1 != cate_id.to_i)
        cate = Category.find(cate_id)
        if sort == "hot"
          @movies = Movie.where(category_id:cate_id).order("view_count desc")
        elsif sort == "review"
          @movies = Movie.where(category_id:cate_id).order("review_count desc")
        elsif sort == "time"
          @movies = Movie.where(category_id:cate_id).order("created_at desc")
        else
          @movies = Movie.where(category_id:cate_id)
        end
      else
        @movies = Movie.recent
      end


      @categories = Category.all

      if  @movies.blank?
          @hotMovie = Movie.recent.first
      else
        @hotMovie = @movies.first
      end

      # render plain: params.inspect + @movies.inspect

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


    def favoriteIt

      @movie = Movie.find(params[:movie_id])
      if @movie
        @favorite = Favorite.where(user_id: current_user.id, movie_id: @movie.id)
        if @favorite.blank?
           @favorite = Favorite.new
           @favorite.user = current_user
           @favorite.movie = @movie
           if @favorite.save
             flash[:notice] = "Favorite successful!";
             redirect_to movies_path
           else
             flash[:error] = "Favorite movie failed!";
             redirect_to movies_path
          end
        else
          flash[:warning] = "You have already favorite it!";
          redirect_to movies_path
        end


      else
        flash[:error] = "Movies dont exist!";
        redirect_to movies_path
      end
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :brief, :cover_url, :featurecoverurl)
    end

    def category_params
      params.require(:category).permit(:id)
    end

end
