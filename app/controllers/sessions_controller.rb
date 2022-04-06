class SessionsController < ApplicationController
    def new
        # No need for anything in here, we are just going to render our
        # new.html.erb AKA the login page
      end

      def create
        @user = User.new(user_params)
        if @user.save
          flash[:notice] = "User sign up successfully!"
          redirect_to root_path
        else
          flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
          redirect_to sessions_signup_path
        end
      end
    
      def authenticate
        # Look up User in db by the email address submitted to the login form and
        # convert to lowercase to match email in db in case they had caps lock on:
        user = User.find_by(email: params[:email])
        
        # Verify user exists in db and run has_secure_password's .authenticate() 
        # method to see if the password submitted on the login form was correct: 
        if user && user.authenticate(params[:password]) 
          # Save the user.id in that user's session cookie:
          session[:user_id] = user.id.to_s
          session[:user_name] = user.name
          redirect_to posts_path, notice: 'Successfully logged in!'
        else
          # if email or password incorrect, re-render login page:
          flash.now.alert = "Incorrect email or password, try again."
          render :new
        end
      end
    
      def destroy
        # delete the saved user_id key/value from the cookie:
        session.delete(:user_id)
        redirect_to root_path, notice: "Logged out!"
      end

      def signup
        @user = User.new
      end

      private
      def user_params
        params.require(:users).permit( :name, :email, :password, :userType, :phone, :dob, :address, :profile)
      end
end
