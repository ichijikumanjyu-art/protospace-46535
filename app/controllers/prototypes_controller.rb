class PrototypesController < ApplicationController

  before_action :set_prototype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.includes(:user, image_attachment: :blob).all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    @prototype.user = current_user 

    if @prototype.save
      redirect_to root_path, notice: '投稿が完了しました'
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: '更新が完了しました'
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path, notice: '投稿を削除しました'
  end
 
  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def redirect_unless_owner
    unless user_signed_in? && current_user == @prototype.user
      redirect_to root_path, alert: "アクセス権がありません"
    end
  end

end
