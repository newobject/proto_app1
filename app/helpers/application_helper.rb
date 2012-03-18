require 'net/http'
require 'uri'

module ApplicationHelper
  
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
  
  def user_signed_in?
    not current_user.nil?
  end
  
  def apps_from_protal
    return [] unless user_signed_in?
    
    uri = URI.parse("http://localhost:3000/api/v1/apps.json?user_id=#{session[:user_id]['uid']}")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
  
  def nav_nodes_from_protal
    return [] unless user_signed_in?
    
    uri = URI.parse("http://localhost:3000/api/v1/nav_nodes.json?user_id=#{session[:user_id]['uid']}&app_code=4a3b4b7eefcdd701")
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end
  
  def logout_from_protal
    puts = "===================: here1"
    return [] unless user_signed_in?
    puts = "===================: here2"
    
    uri = URI.parse("http://localhost:3000/users/sign_out")
    puts = "===================: here3"
    http = Net::HTTP.new(uri.host, uri.port)
    puts = "===================: here4"
    req = Net::HTTP::Delete.new("/users/sign_out")
    puts = "===================: here5"
    res = http.request(req)
    puts = "===================: here6"
    puts = "===================: #{res}"
  end
end
