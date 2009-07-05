require 'test_helper'

class SlipsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slips)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slip" do
    assert_difference('Slip.count') do
      post :create, :slip => { }
    end

    assert_redirected_to slip_path(assigns(:slip))
  end

  test "should show slip" do
    get :show, :id => slips(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => slips(:one).id
    assert_response :success
  end

  test "should update slip" do
    put :update, :id => slips(:one).id, :slip => { }
    assert_redirected_to slip_path(assigns(:slip))
  end

  test "should destroy slip" do
    assert_difference('Slip.count', -1) do
      delete :destroy, :id => slips(:one).id
    end

    assert_redirected_to slips_path
  end
end
