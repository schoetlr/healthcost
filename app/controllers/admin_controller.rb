class AdminController < ApplicationController
  before_action :require_admin
  layout 'admin'



  private

  def require_admin
    unless current_provider && current_provider.admin == true
      flash[:error] = "Not logged in as admin"
      redirect_to root_path
    end
  end
end
