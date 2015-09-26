require 'test_helper'

class ProceduresControllerTest < ActionController::TestCase
  setup do
    @procedure = procedures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:procedures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create procedure" do
    assert_difference('Procedure.count') do
      post :create, procedure: { code: @procedure.code, name: @procedure.name, price: @procedure.price }
    end

    assert_redirected_to procedure_path(assigns(:procedure))
  end

  test "should show procedure" do
    get :show, id: @procedure
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @procedure
    assert_response :success
  end

  test "should update procedure" do
    patch :update, id: @procedure, procedure: { code: @procedure.code, name: @procedure.name, price: @procedure.price }
    assert_redirected_to procedure_path(assigns(:procedure))
  end

  test "should destroy procedure" do
    assert_difference('Procedure.count', -1) do
      delete :destroy, id: @procedure
    end

    assert_redirected_to procedures_path
  end
end
