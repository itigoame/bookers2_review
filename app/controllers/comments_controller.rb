class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:id])
    @comment = current_user.comments.new(book_id: @book.id)
    @comment.save
    redirect_back

  end

  def destroy
    @book = Book.find(params[:id])
    @comment = current_user.comments.find_by(book_id: @book.id)
    @comment.destroy
    redirect_back
  end
end
