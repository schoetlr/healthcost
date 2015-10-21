class ApplicationController < ActionController::Base
	 before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

   def configure_permitted_parameters
        [:sign_up, :account_update].each do |action|
            devise_parameter_sanitizer.for(action).push(:name, :address)
        end
   end

   rescue_from Provider::NotAuthorized, with: :deny_access
   private

    def deny_access
      render 'static_pages/not_authorized', status: 403
    end


end
