class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show]
  before_action :current_user, only: [:edit, :update]

  def index
    @prototypes = Prototype.includes(:user)
  end
  def new
    @prototype = Prototype.new
  end
  def create
    @prototype = Prototype.create(proto_params)
    if @prototype.save
      redirect_to root_path
    else 
      # 新規投稿ページへ戻る
      render :new
    end
  end
  def show
    @comment = Comment.new(comment_params)
    @comments = @prototype.comments.includes(:user)
  end
  def update
    #これは何やってるの？ A.現在指定してる投稿を受け取っている
    prototype = Prototype.find(params[:id])
    if prototype.update(proto_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  def edit
    unless current_user == @prototype.user 
      redirect_to root_path
    end
  end
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private
  def proto_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  def comment_params
    
  end
  def correct_user
    unless current_user.id == @prototype.user.id
      redirect_to root_path
    end
  end

end
