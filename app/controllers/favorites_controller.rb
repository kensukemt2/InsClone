class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(contribution_id: params[:contribution_id])
    redirect_to user_path
  end

  def destroy
    favorite = current_user.favorite.find_by(contribution_id: params[:contribution_id]).destroy
    redirect_to user_path
  end
end
