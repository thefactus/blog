class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!, except: [:index]

  def index
    unless user_signed_in?
      redirect_to '/users/sign_in'
    else
      authenticate_user!
    end
  end
end
