class SessionController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

	def login_attempt
		authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
		if authorized_user
        session[:user_id] = authorized_user.id
				flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
				redirect_to(:action => 'home')
		else
				flash[:notice] = "Invalid Username or Password"
				flash[:color]= "invalid"
				render "login"	
		end
	end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end

  def login
    respond_to do | format |
      format.html
    end
  end

  def home
    respond_to do | format |
      format.html
    end
  end

  def profile
      respond_to do | format |
      format.html
    end
  end

  def setting
      respond_to do | format |
      format.html
    end
  end
end
