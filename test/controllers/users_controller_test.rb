require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:user_one)
  end

  test 'can render new' do
    get "/users/new"
    assert_template :new
    assert_response :success
  end

  test 'can render index' do
    get "/users"
    assert_template :index
    assert_response :success
    assert_equal User.count, assigns(:users).count
  end

  test 'can render show' do
    get "/users/#{@user.id}"
    assert_template :show
    assert_response :success
    assert_equal @user, assigns(:user)
  end

  test 'can create user' do
    assert_difference('User.count') do
      post "/users", params: { user: { first_name: "Larry",
                                     last_name: "Brown",
                                     email: "larry.brown@larry.org",
                                     password: "password",
                                     password_confirmation: "password"
                                   }
                              }
    end
    user = assigns(:user)
    assert_redirected_to user_path(user)
    assert_equal "#{user.first_name} #{user.last_name} was sucessfully created", flash[:notice]
    assert_equal "Larry", user.first_name
    assert_equal "Brown", user.last_name
    assert_equal "larry.brown@larry.org", user.email
    assert_equal user, User.find(user.id).try(:authenticate, 'password')
  end

  test 'an unsuccessful create redirects to new' do
    assert_no_difference('User.count') do
      post "/users", params: { user: { first_name: "Larry",
                                     last_name: "Brown",
                                     email: "larry.brown@larry.org",
                                     password: "password",
                                     password_confirmation: "not_password"
                                   }
                              }
    end
    assert_redirected_to new_user_path
    assert_equal "User did not save", flash[:error]
  end

  test 'can update user' do
    patch "/users/#{@user.id}", params: { user: { id: @user.id,
                                                  first_name: "Larry",
                                                  last_name: "Brown",
                                                  email: "larry.brown@larry.org",
                                                  password: "password",
                                                  password_confirmation: "password",
                                                }
                                        }
    user = assigns(:user)
    assert_redirected_to user_path(user)
    assert_equal "#{user.first_name} #{user.last_name} was sucessfully updated", flash[:notice]
    assert_equal "Larry", user.first_name
    assert_equal "Brown", user.last_name
    assert_equal "larry.brown@larry.org", user.email
    assert_equal user, User.find(user.id).try(:authenticate, 'password')
  end

  test 'an unsuccessful update renders edit view' do
    patch "/users/#{@user.id}", params: { user: { id: @user.id,
                                                  first_name: nil,
                                                  last_name: "Brown",
                                                  email: "larry.brown@larry.org",
                                                  password: "password",
                                                  password_confirmation: "password",
                                                }
                                        }
    assert_redirected_to edit_user_path(@user)
    assert_equal "User did not update", flash[:error]
  end

  test 'can delete user' do
    assert_difference('User.count', -1) do
      delete "/users/#{@user.id}"
    end

    assert_raise(ActiveRecord::RecordNotFound) do
      User.find(@user.id)
    end

    assert_redirected_to users_path
  end
end
