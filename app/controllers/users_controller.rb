class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]

    if @user.save
      flash[:notice] = 'The User is successfully saved!'
      redirect_to signup_path
    else
      flash[:error] = @user.errors.full_messages[0]
      redirect_to signup_path
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update_attributes params[:user]
      flash[:notice] = 'The User is successfully updated!'
      redirect_to edit_user_path
    else
        flash[:error] = @user.errors.full_messages[0]
        redirect_to edit_user_path
    end
  end
end
