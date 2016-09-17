class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book
      flash[:notice] = "#{@book.title} by #{@book.author} was created"
    else
      redirect_to new_book_url
      flash[:error] = "The book was not created, be sure to have a title and author"
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book
      flash[:notice] = "#{@book.title} by #{@book.author} was updated"
    else
      redirect_to edit_book_url(@book)
      flash[:error] = "The book was not updated, be sure to have a title and author"
    end
  end
  #
  def destroy
    @book.destroy
    redirect_to books_url
  end
  #
  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:author, :title)
    end
end
