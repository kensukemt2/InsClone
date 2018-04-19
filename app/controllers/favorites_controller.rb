class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(contribution_id: params[:contribution_id])
    redirect_to user_path(current_user.id)
  end

  def destroy
    favorite = current_user.favorites.find_by(contribution_id: params[:contribution_id]).destroy
    redirect_to user_path(current_user.id)
  end
end
