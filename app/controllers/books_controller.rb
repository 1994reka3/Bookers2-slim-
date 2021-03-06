class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @books = Book.all
    @newbook = Book.new
  end

  def create
    @user = current_user
    @newbook = current_user.books.new(book_params)
    if @newbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@newbook)
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @user = @book.user
    @newbook = Book.new
  end

  def edit
    redirect_to books_path if @book.user.id != current_user.id
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end

