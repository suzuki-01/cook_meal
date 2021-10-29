class CommentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :correct_user, only: [:destroy]
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    Comment.find_by(id: params[:id],recipe_id: params[:recipe_id]).destroy
    redirect_to recipe_path(@recipe)
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :recipe_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
  # def correct_user
  #   comment = current_user.comments.find_by(id: params[:id])
  #   unless comment
  #     redirect_to root_url
  #   end
  # end
end
