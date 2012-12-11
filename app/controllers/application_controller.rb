class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def authenticate_user
    unless session[:user_id]
      redirect_to(:controller => 'session', :action => 'login')
      return false
    else
      # set current user object  to @current_user object variable
      @current_user = User.find session[:user_id]
      return true
    end
  end

  def authenticate_admin
    unless session[:admin_id]
      redirect_to(:controller => 'session', :action => 'login')
      return false
    else
      # set current user object  to @current_user object variable
      @current_user = Admin.find session[:admin_id]
      return true
    end
  end

  def authenticate_user_or_admin
    unless session[:admin_id] or session[:user_id]
      redirect_to(:controller => 'session', :action => 'login')
      return false
    else
      # set current user object  to @current_user object variable
      @current_user = (session[:admin_id] ? Admin.find_by_id(session[:admin_id]) : User.find_by_id(session[:user_id]))
      return true
    end
  end

  def save_login_state
      if session[:user_id] 
        redirect_to(:controller => 'session', :action => 'home')
        return false
      elsif session[:admin_id]
        redirect_to(:controller => 'admins', :action => 'index')
        return false
      else
        return true
      end
  end
end
