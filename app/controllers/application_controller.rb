class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_required

  def login_required
    unless current_user
      respond_to do |format|
        format.html { redirect_to '/auth/proto' }
        format.json { render :json => { :error => 'Access Denied' } }
      end
    end
  end

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find_by_uid(session[:user_id]['uid'])
  end
end
