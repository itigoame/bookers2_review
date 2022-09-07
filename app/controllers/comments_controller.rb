class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.book_id = @book.id
    @comment.save
    @comments = @book.comments
  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.find_by(book_id: @book.id)
    @comment.destroy
    @comments = @book.comments
  end

  private
  def comment_params
    params.require(:comment).permit(:comment_text)
  end

end
