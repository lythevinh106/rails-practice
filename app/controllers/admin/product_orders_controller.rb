class Admin::ProductOrdersController < AdminController
  before_action :set_admin_product_order, only: %i[ show edit update destroy ]

  # GET /admin/product_orders or /admin/product_orders.json
  def index
    @admin_product_orders = Admin::ProductOrder.all
  end

  # GET /admin/product_orders/1 or /admin/product_orders/1.json
  def show
  end

  # GET /admin/product_orders/new
  def new
    @admin_product_order = Admin::ProductOrder.new
  end

  # GET /admin/product_orders/1/edit
  def edit
  end

  # POST /admin/product_orders or /admin/product_orders.json
  def create
    @admin_product_order = Admin::ProductOrder.new(admin_product_order_params)

    respond_to do |format|
      if @admin_product_order.save
        format.html { redirect_to admin_product_order_url(@admin_product_order), notice: "Product order was successfully created." }
        format.json { render :show, status: :created, location: @admin_product_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_product_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/product_orders/1 or /admin/product_orders/1.json
  def update
    respond_to do |format|
      if @admin_product_order.update(admin_product_order_params)
        format.html { redirect_to admin_product_order_url(@admin_product_order), notice: "Product order was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_product_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_product_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/product_orders/1 or /admin/product_orders/1.json
  def destroy
    @admin_product_order.destroy!

    respond_to do |format|
      format.html { redirect_to admin_product_orders_url, notice: "Product order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_product_order
    @admin_product_order = Admin::ProductOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_product_order_params
    params.fetch(:admin_product_order, {})
  end
end
