require 'test_helper'

class OnlineLendingControllerTest < ActionController::TestCase
  test "should get register" do
    get :register
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get borrower" do
    get :borrower
    assert_response :success
  end

  test "should get lender" do
    get :lender
    assert_response :success
  end

end
