class BooksController < ApplicationController

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    @books = Book.all
    @user = current_user
    if @book_new.save
      redirect_to book_path(@book_new.id)
    else
      render :index
    end
  end

  def show
    @book=Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
  end

  def index
    @books = Book.all

    @book_new = Book.new
    @user = current_user
  end

  def edit
    @book_new = Book.new
  end

  def update

  end

  def destroy
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
      @book.destroy
      redirect_to books_path
    else
      redirect_to books_path
    end
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end

end
