class PostsController < ApplicationController
 before_filter :authenticate
 
def create
     user = User.find_by_id(session[:remember_token])
    @posts = user.posts.build(params[:post])
    
    if @posts.save
      flash[:success] = "Uspesno ste oddali novico"
      redirect_to root_path
    else
      flash[:error] = "Napaka pri oddaji novice"
      redirect_to root_path

    end
  end

  def destroy
  end
end
