require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  def setup
    @book = books(:book_one)
  end

  test "books index" do
    get books_path
    assert_response :success
  end

  test 'new book' do
    get new_book_path
    assert_response :success
    assert_template "books/new"
  end

  test "create book" do
    assert_difference('Book.count') do
      post books_path, params: { book: {title: "New Title", author: "New Author"} }
    end
    book = assigns(:book)
    assert_redirected_to book
    assert_equal "#{book.title} by #{book.author} was created", flash[:notice]
    assert_equal "New Title", book.title
    assert_equal "New Author", book.author
  end

  test "unsuccessful create book" do
    assert_no_difference('Book.count') do
      post books_path, params: { book: {title: "New Title"} }
    end
    assert_redirected_to new_book_url
    assert_equal "The book was not created, be sure to have a title and author", flash[:error]
  end

  test 'show book' do
    get book_path(@book)
    assert_response :success
    assert_template "books/show"
    assert_equal assigns(:book), @book
  end

  test 'edit book' do
    get edit_book_path(@book)
    assert_response :success
    assert_template "books/edit"
    assert_equal assigns(:book), @book
  end

  test 'update book' do
    patch book_path(@book), params: { book: {title: "New Title", author: "New Author"} }
    assert_redirected_to @book
    book = assigns(:book)
    assert_equal "#{book.title} by #{book.author} was updated", flash[:notice]
    assert_equal "New Title", book.title
    assert_equal "New Author", book.author
  end

  test 'unsuccessful update book' do
    patch book_path(@book), params: { book: {title: "New Title", author: nil} }
    assert_redirected_to edit_book_url(@book)
    assert_equal "The book was not updated, be sure to have a title and author", flash[:error]
  end

  test 'destroy_book' do
    assert_difference('Book.count', -1) do
      delete book_path(@book)
    end
    assert_redirected_to books_url
  end
end
