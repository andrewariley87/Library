class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
      flash[:notice] = "#{@user.first_name} #{@user.last_name} was sucessfully created"
    else
      redirect_to new_user_path
      flash[:error] = "User did not save"
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "#{@user.first_name} #{@user.last_name} was sucessfully updated"
    else
      redirect_to edit_user_path(@user)
      name = (@user.first_name.present? && @user.last_name.present?) ? @user.full_name : "User"
      flash[:error] = "#{name} did not update"
    end
  end

  def destroy
    @user.delete
    redirect_to users_path
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :email,
                                   :password,
                                   :password_confirmation)
    end
end
