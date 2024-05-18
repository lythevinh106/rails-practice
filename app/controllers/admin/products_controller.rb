class Admin::ProductsController < AdminController
  include Pagy::Backend
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :active_navlink

  # GET /admin/products or /admin/products.json
  def index

    @sort_price_query = params[:sort_price]
    @sort_id_query = params[:sort_id]
    @sort_search_query = params[:search_query]

    @products = Product.all

    unless @sort_price_query.nil?
      @products = @products.sort_by_price(@sort_price_query)
    end
    unless @sort_id_query.nil?
      @products = @products.sort_by_id(@sort_id_query)
    end

    unless @sort_search_query.nil?
      @products = @products.search_by_title(@sort_search_query)
    end

    @pagy, @products = pagy(@products, items: 4)

  rescue Pagy::OverflowError
    params[:page] = 1
    retry
  end

  # GET /admin/products/1 or /admin/products/1.json
  def show

  end

  # GET /admin/products/new
  def new
    @product = Product.new
  end

  # GET /admin/products/1/edit
  def edit
  end

  # POST /admin/products or /admin/products.json
  def create

    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        # @product.image_blob.attach(params[:product][:image_blob])
        format.html { redirect_to new_admin_product_url(Product.new), flash: { success: "Tạo Sản Phẩm Thành Công." } }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1 or /admin/products/1.json
  def update

    respond_to do |format|
      @old_image = @product.image_blob.id
      if @product.update(product_params)
        @product.delete_attached_old_image(@old_image)
        format.html { redirect_to admin_products_url, flash: { success: "Chỉnh Sủa Sản Phẩm Thành Công." } }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy

    @product = Product.find(params[:id])

    if @product.image_blob.attached?
      @product.image_blob.purge
    end

    @product.delete
    respond_to do |format|
      format.html { redirect_to admin_products_url, flash: { success: "Xóa Sản Phẩm Thành Công." } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.fetch(:product, {}).permit(:title, :price, :image_blob, :description, :category_id, :is_active)
  end

  def active_navlink
    session[:active_navlink] = "products"
  end
end
