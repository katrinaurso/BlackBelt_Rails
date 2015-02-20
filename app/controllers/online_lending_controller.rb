class OnlineLendingController < ApplicationController
  def register
  	@lender = Lender.new
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

  def login
  end

  def borrower
  end

  def lender
  end

  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end
end
