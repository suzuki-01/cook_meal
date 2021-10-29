class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_recipe, only: %i(show edit update destroy)

  def index
    @recipes = Recipe.all.order(id: "DESC")
  end

  def show
    @comments = @recipe.comments
    @comment = Comment.new
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "レシピを投稿しました。"
    else
    render :new
    end
  end


  def edit
    if @recipe.user != current_user
      redirect_to recipes_path, alert: "不正なアクセスです。"
    end
  end
  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe), notice: "レシピを更新しました。"
    else
      render :edit
    end
  end
  def destroy
    @recipe.destroy
    redirect_to user_path(current_user), notice: "レシピを削除しました。"
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :image, :comment)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end
end