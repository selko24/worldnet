class SessionsController < ApplicationController
  
  
  def new
    @title = 'Prijava'
  end
  
  def create
    user = User.authenticate(params[:sessions][:email], params[:sessions][:password])
    
    if user.nil?
      #error
      flash[:error] = "Napaka pri prijavi"
      @title = 'Prijava'
      render 'new'
    else
      #ok ustvari sejo
      sign_in(user)
      flash[:success] = "Prijava uspela!"
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
