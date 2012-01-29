module SessionsHelper
  
  def sign_in(user)
    session[:remember_token] = user.id
    #@current_user = user
  end

  def signed_in?
    session[:remember_token].present?
   #!!@current_user
  end
  
  def sign_out
    session.delete(:remember_token)
  end
  
  def whois
    User.find_by_id(session[:remember_token]).surname
  end
  

  def correct_user?(user)
    signed_in? &&
    (user.id == session[:remember_token] || User.find_by_id(session[:remember_token]).admin)
  end
  
  def admin?
    if signed_in? 
    User.find_by_id(session[:remember_token]).admin
    else
      false
    end
  end
   def authenticate
    unless signed_in?
       flash[:error] = "Zato stran morate biti prijavljeni"
       redirect_to login_path
    end
  end
  
end

