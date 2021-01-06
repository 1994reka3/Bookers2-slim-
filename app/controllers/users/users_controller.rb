class Users::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]
  def index
    @users = User.all
    @user = current_user
    @newbook = Book.new
  end

  def show
    @newbook = Book.new
    @user = User.find(params[:id])
    @books = @user.books.all
  end

  def edit
    redirect_to user_path(current_user.id) if @user.id != current_user.id
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "You have updated user_info successfully."
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
