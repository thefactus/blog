module Admin
  class HomeController < AdminController
    def index
      unless user_signed_in?
        redirect_to '/users/sign_in'
      else
        authenticate_user!
      end
    end
  end
end
