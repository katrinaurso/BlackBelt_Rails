class SessionsController < ApplicationController
  def create
  	user = Lender.authenticate(params[:session][:email], params[:session][:password])
  	if user.nil?
  		user = Borrower.authenticate(params[:session][:email], params[:session][:password])
  		if user.nil?
  			flash[:login_error] = "Could not find a user with that email and password combination"
  			redirect_to online_lending_login_path
  		else
  			session[:user_type] = 'borrower'
  			session[:user_id] = user.id
  			redirect_to borrower_path user
  		end
  	else
  		session[:user_type] = 'lender'
  		session[:user_id] = user.id
  		redirect_to lender_path user
  	end
  end

  def destroy
  	session[:user_id] = nil
  	session[:user_type] = nil
  	flash[:message] = 'You have successfully logged out'
  	redirect_to online_lending_login_path
  end
end
