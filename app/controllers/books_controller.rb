class BooksController < ApplicationController

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    @books = Book.all
    @user = current_user
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      render :index
    end
  end

  def show
    @book=Book.find(params[:id])
    @favorites = @book.favorites
    @comment = Comment.new
    @comments = @book.comments

    @user = @book.user
    @book_new = Book.new
  end

  def index
    to = Time.current.at_end_of_day
    from = (to-6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size}.reverse

    @book_new = Book.new
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully"
        redirect_to book_path(@book.id)
      else
        render :edit
      end
    else
      redirect_to books_path
    end
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
