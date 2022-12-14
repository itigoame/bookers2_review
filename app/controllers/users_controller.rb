class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @books = @user.books

    @book_new = Book.new


  end

  def index
    @users = User.all

    @user = current_user
    @book_new = Book.new
  end

  def edit
    @user=User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path(@user.id)
    else
      if @user.update(user_params)
        flash[:notice] = "You have updated user successfully"
        redirect_to user_path(@user.id)
      else
        render :edit
      end
    end
  end

  def followers #フォローしている人一覧
    @user = User.find(params[:id])
    @users = @user.follower_users
  end

  def followings #フォローされている人一覧
    @user = User.find(params[:id])
    @users = @user.following_users
  end

private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
end
