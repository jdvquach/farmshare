class SessionController < ApplicationController
  # def new
  # end
  #
  # def create
  # end
  #
  # def destroy
  # end
  def new

  end
  
  def create
    # see if the email address entered actually corresponds to a user in the table
    user = User.find_by email: params[:email]

    if user.present? && user.authenticate( params[:password] )
      # Successful login:
      # Get Rails to create a new session key to store the user's ID;
      # this is the session key which we will use to check if the user
      # is logged in on all future pages
      session[:user_id] = user.id
      redirect_to user_path( user.id )
    else
      # Bad credentials, i.e. unsuccessful login

      # Set a flash message which exists *just for the next page load*
      flash[:error] = "Invalid email address or password"

      redirect_to( login_path )
    end
  end
  def destroy
    session[:user_id] = nil  # this logs out the user
    redirect_to login_path
  end
end
