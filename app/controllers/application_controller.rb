class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :currentuser

  private

  def currentuser
    @user = current_user.id if current_user
  end
end
