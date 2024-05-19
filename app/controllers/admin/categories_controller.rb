class Admin::CategoriesController < AdminController
  include Pagy::Backend
  before_action :set_admin_category, only: %i[ show edit update destroy ]
  before_action :active_navlink
  # GET /admin/categories or /admin/categories.json
  def index

    @sort_id_query = params[:sort_id]
    @sort_search_query = params[:search_query]

    @categories = Category.all

    unless @sort_id_query.nil?

      @categories = @categories.sort_by_id(@sort_id_query)
    end

    unless @sort_search_query.nil?
      @categories = @categories.search_by_name(@sort_search_query)
    end
    puts " day la thay doi commit của vinhIT "
    puts "day la nhanh commit code cuar branch cuar admin the vinh"
    puts "day la tesst tao ra conflict cua ly the vinh"

    puts "day la tesst xu li conflic chuyeen nhanh cua vinhit sau dc ddax ammend"
    puts "bo sung sau khi revert "

    puts "test git hub commit 1"
    @pagy, @categories = pagy(@categories, items: 2)
  end

  # GET /admin/categories/1 or /admin/categories/1.json
  def show
  end

  # GET /admin/categories/new
  def new
    @category = Category.new
  end

  # GET /admin/categories/1/edit
  def edit
  end

  # POST /admin/categories or /admin/categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save

        format.html { redirect_to new_admin_category_url(Category.new), flash: { notice: "Tạo Danh Mục Thành Công." } }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/categories/1 or /admin/categories/1.json
  def update
    respond_to do |format|

      if @category.update(category_params)

        format.html { redirect_to admin_categories_url, flash: { success: "Chỉnh Sủa Danh Mục Thành Công." } }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/categories/1 or /admin/categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to admin_categories_url, flash: { success: "Xóa Danh Mục Thành Công." } }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.fetch(:category, {}).permit(:name, :is_active)
  end

  def active_navlink
    session[:active_navlink] = "categories"
  end
end
