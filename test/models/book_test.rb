require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test 'book is invalid without title' do
    book = Book.new(author: "Somebody")
    refute book.valid?
    assert book.errors.messages.has_key?(:title)
    assert_equal ["can't be blank"], book.errors.messages[:title]
  end

  test 'book is invalid without author' do
    book = Book.new(title: "The Book")
    refute book.valid?
    assert book.errors.messages.has_key?(:author)
    assert_equal ["can't be blank"], book.errors.messages[:author]
  end

  test 'a book is valid with both an author and a title' do
    book = Book.new(title: "Title", author: "Somebody")
    assert book.valid?
    book.save!
    assert book.persisted?
  end
end
