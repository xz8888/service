class PageController < ApplicationController

  before_filter :authenticate_user!
  respond_to :json
  
  def index
  end

  def home
  	@user = current_user
  	logger.debug current_user.attributes.inspect

  	#here you check if the user is logged in
  end
  
  def login
  	render :layout => 'login'
  end

  def user
     @user = current_user

     respond_to do |format|
	     if @user.id
	   		format.html { redirect_to action: 'home', notice: 'Blob was successfully created.' }
	      	format.json { render action: 'user', status: :created}
	     else
	     	format.html { render action: 'new' }
	     	format.json { render json:{:success => false}, status: :unprocessable_entity}
	     end
 	 end
  end

  def users 
    @users = User.all
  end
end
 