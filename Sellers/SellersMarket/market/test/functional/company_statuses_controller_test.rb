require 'test_helper'

class CompanyStatusesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:company_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company_status" do
    assert_difference('CompanyStatus.count') do
      post :create, :company_status => { }
    end

    assert_redirected_to company_status_path(assigns(:company_status))
  end

  test "should show company_status" do
    get :show, :id => company_statuses(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => company_statuses(:one).id
    assert_response :success
  end

  test "should update company_status" do
    put :update, :id => company_statuses(:one).id, :company_status => { }
    assert_redirected_to company_status_path(assigns(:company_status))
  end

  test "should destroy company_status" do
    assert_difference('CompanyStatus.count', -1) do
      delete :destroy, :id => company_statuses(:one).id
    end

    assert_redirected_to company_statuses_path
  end
end
