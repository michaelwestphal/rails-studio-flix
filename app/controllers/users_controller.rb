class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  # FIXME: How do we protect against exposing "username/email has already been taken" type
  #  of errors providing a system scanning us too much information?
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'Thanks for signing up!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # FIXME: If a user in in Account Settings and they logout (via deleting their session cookie)
  #  how can we protect this route and others like it?
  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to movies_url, status: :see_other, alert: 'Account successfully deleted!'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(:name, :username, :email, :password, :password_confirmation)
  end
end
