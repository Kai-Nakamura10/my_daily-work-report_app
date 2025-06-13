class ApplicationController < ActionController::Base
  before_action :require_login, except: [:new, :create], unless: -> { controller_name == "homes" }
  private
  def redirect_if_logged_in
    redirect_to reports_path if logged_in?
  end
end
