class PagesController < ApplicationController
  def home
    @title = 'Domov'
    if signed_in?
    user = User.find_by_id(session[:remember_token])
    @post = user.posts.build
    end
   
   @posts = Post.all
   
  end
      
  def contact
    @title = 'Kontakt'
  end
  
  def about
    @title = 'O nas'
  end
  
end
