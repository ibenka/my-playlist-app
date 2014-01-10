class ApplicationController < ActionController::Base
  respond_to :html, :js
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :provider, :uid, :email]
    devise_parameter_sanitizer.for(:sign_in) << [:provider, :uid, :email]
    devise_parameter_sanitizer.for(:account_update) << [:name, :avatar, :email]
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    topics_path
  end
end
