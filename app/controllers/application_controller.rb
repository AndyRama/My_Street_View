class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :currentuser

  private

  def currentuser
    @user = current_user.id if current_user
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
