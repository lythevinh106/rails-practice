require "test_helper"

class Admin::ProductOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_product_order = admin_product_orders(:one)
  end

  test "should get index" do
    get admin_product_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_product_order_url
    assert_response :success
  end

  test "should create admin_product_order" do
    assert_difference("Admin::ProductOrder.count") do
      post admin_product_orders_url, params: { admin_product_order: {  } }
    end

    assert_redirected_to admin_product_order_url(Admin::ProductOrder.last)
  end

  test "should show admin_product_order" do
    get admin_product_order_url(@admin_product_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_product_order_url(@admin_product_order)
    assert_response :success
  end

  test "should update admin_product_order" do
    patch admin_product_order_url(@admin_product_order), params: { admin_product_order: {  } }
    assert_redirected_to admin_product_order_url(@admin_product_order)
  end

  test "should destroy admin_product_order" do
    assert_difference("Admin::ProductOrder.count", -1) do
      delete admin_product_order_url(@admin_product_order)
    end

    assert_redirected_to admin_product_orders_url
  end
end
