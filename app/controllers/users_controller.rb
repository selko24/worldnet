class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
   def index
    @users = User.all
    @title = "Vsi"
  end
   def show
    @user = User.find(params[:id])
    @title = ""
  end

  def new
    @title = "Prijava"

    @user = User.new

  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      flash[:success] = "Uspesno ste se registrirali"
      redirect_to @user
    else
      flash[:error] = "Napaka pri registraciji"
      render 'new'

    end
  end

 
  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Uspesno izbrisano"
    redirect_to users_path
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Uspesno posodobljeno"
      redirect_to @user
    else
      flash[:error] = "Napaka pri posodobitvi"
      render 'edit'

    end
    
  end
  
  private
 
  
  def correct_user
    @user = User.find(params[:id])
    unless correct_user?(@user)
       flash[:error] = "To ni vasa stran,ne diraj!"
       redirect_to root_path
    end
  end
  
   
  def admin_user
    
    unless admin?
       flash[:error] = "Zato stran morate biti administrator!"
       redirect_to root_path
    end
  end
 
end
