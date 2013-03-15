require 'net/http'

class ApplicationController < ActionController::Base
  helper :all
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'df57ade46c7069406f87b50dfc8a556c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  def sub_layout
    "welcome"
  end
  
protected
  
  def local_request?
    ["127.0.0.1", "140.247.154.21"].include?(request.remote_ip)
  end
  
private
  
  def authorize(user_type)
    unless user_type.classify.constantize.find_by_id(session[:user_id]) and session[:user_type] == user_type
      flash[:notice] = "You must login as a " + user_type + " to do that!"
      redirect_to(:controller => 'welcome', :action => 'index')
    end
  end
  
end
