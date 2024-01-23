# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :redirect_if_authenticated, only: %i[create new]
  def create
    @user = User.find_by(email: params[:user][:email]&.downcase)
    if @user.present?
      if @user.unconfirmed?
        redirect_to new_confirmation_path, notice: 'Incorrect credentials'
      elsif @user.authenticate(params[:user][:password])
        login(@user)
        redirect_to root_path, notice: 'Successfully logged in'
      else
        flash[:notice] = 'Invalid credentials'
        render 'sessions/new', status: :unprocessable_entity
      end
    else
      flash[:notice] = 'Invalid credentials'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logged out'
  end
  def new; end
end
