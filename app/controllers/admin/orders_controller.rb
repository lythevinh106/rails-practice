class Admin::OrdersController < AdminController
  include Pagy::Backend
  before_action :set_order, only: %i[ show edit update destroy ]
  before_action :active_navlink, :handle_measure

  # GET /admin/orders or /admin/orders.json
  def measure

    render "measure"

  end

  def index
    @orders = Order.all

    @sort_id_query = params[:sort_id]
    @filter_status_query = params[:status]
    @search_query = params[:search_query]

    unless @sort_id_query.nil?
      @orders = @orders.sort_by_id(@sort_id_query)
    end
    unless @search_query.nil?
      @orders = @orders.search_by_user_name(@search_query)
    end

    unless @filter_status_query.nil?
      @orders = @orders.filter_by_status(@filter_status_query)
    end

    @pagy, @orders = pagy(@orders, items: 2)

  rescue Pagy::OverflowError
    params[:page] = 1
    retry
  end

  # GET /admin/orders/1 or /admin/orders/1.json
  def show
  end

  # GET /admin/orders/new
  def new
    @order = Order.new
  end

  # GET /admin/orders/1/edit
  def edit
  end

  # POST /admin/orders or /admin/orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        # @order.image_blob.attach(params[:product][:image_blob])
        format.html { redirect_to new_admin_order_url(Order.new), flash: { success: "Tạo Dơn Hàng Thành Công." } }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/orders/1 or /admin/orders/1.json
  def update

    pp order_params_for_update

    respond_to do |format|

      if @order.update(order_params_for_update)

        format.html { redirect_to admin_orders_url, flash: { success: "Cập Nhật Đơn Hàng Thành Công." } }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/orders/1 or /admin/orders/1.json
  def destroy
    pp @order
    @order.delete
    respond_to do |format|
      format.html { redirect_to admin_orders_url, flash: { success: "Xóa Sản Phẩm Thành Công." } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.fetch(:order, {}).permit(:order_date, :user_id, :status)
  end

  def order_params_for_update
    params
      .fetch(:order, {})
      .permit(:order_date, :user_id, :status,
              product_orders_attributes: [:id, :quantity, :product_id, :order_id])
  end

  def active_navlink
    session[:active_navlink] = "orders"
  end

  def handle_measure
    @number_was_sold_day = Order.number_was_sold_day
    @number_was_sold_day_in_7_day = Order.number_was_sold_day(7)
    @revenue_today = Order.revenue_by_day(2)
    @revenue_7_day = Order.revenue_by_day(7)

  end
end
