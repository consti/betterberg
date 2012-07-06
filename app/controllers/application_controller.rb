class ApplicationController < ActionController::Base
  protect_from_forgery

  
  private
  
    def admin_only!
      current_user.try(:admin?) or redirect_to :back
    end

end
