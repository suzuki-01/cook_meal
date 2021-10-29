class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_user, only: %i(show edit update destroy follow follower)

  def follow
    @users = @user.follower
  end

  def follower
    @users = @user.followed
  end

  def index
    @users = User.all
  end

  def show
  end

  def edit
    if @user != current_user
        redirect_to user_path(current_user), alert: "不正なアクセスです。"
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
  end

  private
  def user_params #ストロングパラメーター
    params.require(:user).permit(:username, :email, :profile, :profile_image) #許可されているキー
  end

  def set_user
    @user = User.find_by(params[:id])
  end
end
