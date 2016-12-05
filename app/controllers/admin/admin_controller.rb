module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!

    def index
      unless user_signed_in?
        redirect_to '/users/sign_in'
      else
        authenticate_user!
      end
    end
  end
end
