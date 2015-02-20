class OnlineLendingController < ApplicationController
  def register
  	@lender = Lender.new
  	@borrower = Borrower.new
  end

  def create_lender
  	@lender = Lender.create(lender_params)
  	if @lender.save
  		session[:user_id] = @lender.id
  		session[:user_type] = 'lender'
  		redirect_to lender_path @lender
  	else
  		flash[:lender_errors] = @lender.errors.full_messages
  		redirect_to online_lending_register_path
  	end
  end

    def create_borrower
  	@borrower = Borrower.create(borrower_params)
  	if @borrower.save
  		session[:user_id] = @borrower.id
  		session[:user_type] = 'borrower'
  		redirect_to borrower_path @borrower
  	else
  		flash[:borrower_errors] = @borrower.errors.full_messages
  		redirect_to online_lending_register_path
  	end
  end

  def login
  	@message = flash[:message]
  	@error = flash[:login_error]
  end

  def lender
  	if session[:user_type] == 'lender'
	  	@lender = Lender.find(params[:id])
	  	@borrowers = Borrower.all
	else 
		redirect_to online_lending_login_path
	end
  end

  def borrower
  	if session[:user_type] == 'borrower'
  		@borrower = Borrower.find(params[:id])
  	else 
  		redirect_to online_lending_login_path
  	end
  end

  def lend_money
  	if session[:user_type] != 'lender'
  		redirect_to online_lending_login_path
  	end
  	@lender = Lender.find(session[:user_id])
  	@borrower = Borrower.find(params[:id])
  	if @lender.update(money:@lender.money-params[:money].to_i)
  		if @borrower.raised.nil?
  			@borrower.update(raised:params[:money].to_i)
  		else
  			@borrower.update(raised:@borrower.raised + params[:money].to_i)
  		end
  	end
  	redirect_to lender_path @lender
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end

  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description, :raised)
  end
end
