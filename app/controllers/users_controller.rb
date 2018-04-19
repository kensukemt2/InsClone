class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]
  def index
  end

  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    @cache = params[:cache][:image]

    if @cache.empty?
    else
      @user.image.retrieve_from_cache! @cache
    end

    if @user.save
      current_user.id = @user.id
      redirect_to new_session_path(@user.id)
    else
      render 'new'
    end
  end

  def confirm
    @user = User.new(user_params)
    render :new if @user.invalid?
  end

  def show
    @contributions = @user.contributions
    @favorite_conts = @user.favorite_conts
  end

  def edit
  end

  def update
    if @user.update(user_edit_params)
      redirect_to @user, notice: "更新しました"
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation, :image)
  end
  def user_edit_params
    params.require(:user).permit(:name, :email, :image)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
