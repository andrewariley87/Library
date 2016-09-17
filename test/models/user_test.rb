require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'a user must have a first name to be valid' do
    user = User.new(last_name: "User",
                    email: "example@example.com",
                    password: "ABC1234")
    refute user.valid?
    assert user.errors.messages.has_key?(:first_name)
    assert_equal ["can't be blank"], user.errors.messages[:first_name]
    refute user.save
  end

  test 'a user must have a last name to be valid' do
    user = User.new(first_name: "New",
                    email: "example@example.com",
                    password: "ABC1234")
    refute user.valid?
    assert user.errors.messages.has_key?(:last_name)
    assert_equal ["can't be blank"], user.errors.messages[:last_name]
    refute user.save
  end

  test 'a user must have a email to be valid' do
    user = User.new(first_name: "New",
                    last_name: "User",
                    password: "ABC1234")
    refute user.valid?
    assert user.errors.messages.has_key?(:email)
    assert_equal ["can't be blank"], user.errors.messages[:email]
    refute user.save
  end

  test 'a user must have a password to be valid' do
    user = User.new(first_name: "New",
                    last_name: "User",
                    email: "example@example.com")
    refute user.valid?
    assert user.errors.messages.has_key?(:password)
    assert_equal ["can't be blank"], user.errors.messages[:password]
    refute user.save
  end

  test 'a valid user' do
    user = User.new(first_name: "New",
                    last_name: "User",
                    email: "example@example.com",
                    password: "ABC1234")
    assert user.valid?
    assert user.save
  end

  test 'a users password can be authenticated' do
    user = User.new(first_name: "New",
                    last_name: "User",
                    email: "example@example.com",
                    password: "ABC1234")
    user.save
    assert user.authenticate(user.password)
    refute user.authenticate(!user.password)
  end

  test 'will not save if password and password confirmation do not match' do
    user = User.new(first_name: "New",
                    last_name: "User",
                    email: "example@example.com",
                    password: "match",
                    password_confirmation: "not match")
    refute user.valid?
    refute user.save
    user.errors.has_key?(:password_confirmation)
    assert_equal ["doesn't match Password"], user.errors[:password_confirmation]
  end

  test 'will save if password and password confirmation match' do
    user = User.new(first_name: "New",
                    last_name: "User",
                    email: "example@example.com",
                    password: "match",
                    password_confirmation: "match")
    assert user.valid?
    assert user.save
  end

  test 'full name returns instance of user full name' do
    user = users(:user_one)
    assert_equal "New", user.first_name
    assert_equal "User", user.last_name
    assert_equal "New User", user.full_name
  end
end
