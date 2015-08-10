require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(user_name: "Example user", password: "My_Den", password_confirmation: "My_Den")
  end
  
  test "should be valid" do
  	assert @user.valid?
  end
  test "user_name should be present" do
  	@user.user_name = " "
  	assert_not @user.valid?
  end
  test "name should not be too long" do
  	@user.user_name = "a" * 51
  	assert_not @user.valid?
  end

  test "user_names should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.user_name = @user.user_name.upcase
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "password should not be blank" do
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid?
  end

  test "password should have minimum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end
end
