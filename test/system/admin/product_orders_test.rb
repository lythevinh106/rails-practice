require "application_system_test_case"

class Admin::ProductOrdersTest < ApplicationSystemTestCase
  setup do
    @admin_product_order = admin_product_orders(:one)
  end

  test "visiting the index" do
    visit admin_product_orders_url
    assert_selector "h1", text: "Product orders"
  end

  test "should create product order" do
    visit admin_product_orders_url
    click_on "New product order"

    click_on "Create Product order"

    assert_text "Product order was successfully created"
    click_on "Back"
  end

  test "should update Product order" do
    visit admin_product_order_url(@admin_product_order)
    click_on "Edit this product order", match: :first

    click_on "Update Product order"

    assert_text "Product order was successfully updated"
    click_on "Back"
  end

  test "should destroy Product order" do
    visit admin_product_order_url(@admin_product_order)
    click_on "Destroy this product order", match: :first

    assert_text "Product order was successfully destroyed"
  end
end
