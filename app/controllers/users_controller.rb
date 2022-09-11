class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @books = @user.books

    @book_new = Book.new
    # dm機能
    @current_entry = Entry.where(user_id: current_user.id)
    @partner_entry = Entry.where(user_id: @user.id)

    unless @user.id == current_user.id
      @current_entry.each do |cu|
        @partner_entry.each do |pu|
          if cu.room_id == pu.room_id then
            @is_room = true
            @room_id = cu.room_id
          end
         end
      end
      # @is_roomが存在しない場合roomを新規作成する
      unless @is_room
        @room = Room.new
        @entry = Entry.new
      end
    end
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
