class Account::FavoritesController < ApplicationController
  before_action :authenticate_user! , only:[:index,:favoriteIt,:unfavorite]

  def index
    @favorites = Favorite.where(user_id: current_user.id)
  end

  def unfavorite

    # render plain: params.inspect
    # return

    begin
        favorite  = Favorite.find(params[:favorite_id])
    rescue ActiveRecord::RecordNotFound => e
    end

    if favorite != nil
      @favorite = favorite
      if @favorite.delete
        flash[:notice] = "Favorite successful!"
      else
        flash[:warning] = "Unfavorite failed!";
      end

    else
      flash[:warning] = "You have never favorite it, so you can un-favorite it!"

    end
      redirect_to account_favorites_path
  end

end
