class LikesController < ApplicationController
  before_action :set_recipe, only: [:create, :destroy]

  def create
    @like = Like.create(user_id: current_user.id, recipe_id: params[:recipe_id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
    like.destroy
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end
end
