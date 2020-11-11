class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else 
      # ビューを経由して別のコントローラーに移動する時インスタンス変数はリセットされるので再定義する必要がある
      @prototype = @comment.prototype
      @comment = @prototype.comments
      render "/prototypes/show"
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:comment).merge(prototype_id: params[:prototype_id], user_id: current_user.id)
  end

end
