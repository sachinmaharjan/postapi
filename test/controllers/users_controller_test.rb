require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { city: @user.city, name: @user.name }
    end

    assert_response :success
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

end
