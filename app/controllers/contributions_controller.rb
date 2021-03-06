class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:edit, :update, :show, :destroy]
  before_action :force_top, only: [:new, :show, :edit]

  def top
    if current_user.nil?
    else
      redirect_to user_path(current_user.id)
    end
  end

  def index
    @contributions = Contribution.all
  end

  def new
    if params[:back]
      @contribution = Contribution.new(contribution_params)
    else
      @contribution = Contribution.new
    end
  end

  def create
    @contribution = Contribution.new(contribution_params)
    @contribution.user_id = current_user.id
    @cache = params[:cache][:image]

    if @cache.empty?
    else
      @contribution.image.retrieve_from_cache! @cache
    end

    if @contribution.save
      InsMailer.contribution_mail(@contribution).deliver
      redirect_to user_path(@contribution.user_id)
    else
      render 'new'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(contribution_id: @contribution.id)
  end

  def edit
  end

  def update
    if @contribution.update(contribution_params)
      redirect_to user_path(current_user.id), notice: '投稿を編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    @contribution.destroy
    redirect_to user_path(current_user.id), notice: '投稿を削除しました'
  end

  def confirm1
    @contribution = Contribution.new(contribution_params)
    @contribution.user_id = current_user.id
    render :new if @contribution.invalid?
  end

  private

  def contribution_params
    params.require(:contribution).permit(:image, :caption)
  end

  def set_contribution
    @contribution = Contribution.find(params[:id])
  end

  def force_top
    if current_user.nil?
      redirect_to  new_session_path, notice: "ログインしてください"
    end
  end
end
