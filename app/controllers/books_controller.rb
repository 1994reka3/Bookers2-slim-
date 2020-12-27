class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def show
    @user = @book.user
    @newbook = Book.new
  end

  def edit
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
