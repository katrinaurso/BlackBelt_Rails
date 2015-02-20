class OnlineLendingController < ApplicationController
  def register
  	@lender = Lender.new
  	@borrower = Borrower.new
  end

  def create_lender
  	@lender = Lender.create(lender_params)
  	if @lender.save
  		redirect_to lender_path @lender
  	else
  		flash[:lender_errors] = @lender.errors.full_messages
  		redirect_to online_lending_register_path
  	end
  end

    def create_borrower
  	@borrower = Borrower.create(borrower_params)
  	if @borrower.save
  		redirect_to borrower_path @borrower
  	else
  		flash[:borrower_errors] = @borrower.errors.full_messages
  		redirect_to online_lending_register_path
  	end
  end

  def login
  end

  def lender
  	@lender = Lender.find(params[:id])
  	@borrowers = Borrower.all
  end

  def borrower
  	@borrower = Borrower.find(params[:id])
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end

  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money, :purpose, :description, :raised)
  end
end
