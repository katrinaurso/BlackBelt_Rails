class SessionsController < ApplicationController
  def create
  	#check to see if email is a borrower or a lender and act appropriatly
  end

  def destroy
  	#destroy session
  	flash[:message] = 'You have successfully logged out'
  	redirect_to online_lending_login_path
  end
end
