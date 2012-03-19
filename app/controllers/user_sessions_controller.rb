class UserSessionsController < ApplicationController
  before_filter :login_required, :only => [ :destory ]

  # omniauth callback method 
  def create
    omniauth = env['omniauth.auth']
    
    user = User.find_by_uid(omniauth['uid'])
    unless user
      user = User.create!(:uid => omniauth['uid'], :email => omniauth['extra']['raw_info']['info']['email'])
    end

    # Currently storing all the info
    session[:user_id] = omniauth

    flash[:notice] = "Successfully logged in"
    redirect_to root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]
  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    session[:user_id] = nil

    #TODO logout from protal
    redirect_to root_path
  end
end
