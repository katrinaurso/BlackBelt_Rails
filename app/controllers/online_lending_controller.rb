class OnlineLendingController < ApplicationController
  def register
  	@lender = Lender.new
  	@borrower = Borrower.new
  	@lender_errors = flash[:lender_errors]
  	@borrower_errors = flash[:borrower_errors]
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
	  	@history = History.new
	  	@lendees = History.joins(:borrower).select('*').where(lender:Lender.find(params[:id]))
	else 
		redirect_to online_lending_login_path
	end
  end

  def borrower
  	if session[:user_type] == 'borrower'
  		@borrower = Borrower.find(params[:id])
  		@lenders = History.joins(:lender).select('*').where(borrower:Borrower.find(params[:id]))
  	else 
  		redirect_to online_lending_login_path
  	end
  end

  def lend_money
  	if session[:user_type] != 'lender'
  		redirect_to online_lending_login_path
  	end
  	@lender = Lender.find(session[:user_id])
  	@lender.update(money:@lender.money-params[:amount].to_i)
  	@borrower = Borrower.find(params[:id])
  	if @borrower.raised.nil?
  		@borrower.update(raised:params[:amount].to_i)
  	else
  		@borrower.update(raised:@borrower.raised + params[:amount].to_i)
  	end
  	@history = History.create(amount:params[:amount].to_i, lender:@lender, borrower:@borrower)
  	json_message = {first_name:@borrower.first_name, last_name:@borrower.last_name, purpose:@borrower.purpose, description:@borrower.description, money:@borrower.money, raised:@borrower.raised, amount:@history.amount}
  	render json: json_message
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end

  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description, :raised)
  end
end
