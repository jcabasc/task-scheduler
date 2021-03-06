class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  before_filter :require_user

  helper_method :current_user

  def require_user
    head :unauthorized unless current_user
  end

  protected

  def current_user
      @_current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end


end
