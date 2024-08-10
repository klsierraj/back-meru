class ProductsController < ApplicationController
  before_action :authenticate_request, only: [:create, :update, :destroy, :my_products, :show]
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    render json: @products, status: :ok
  end

  # GET /products/:id
  def show
    if @product
      render json: @product, status: :ok
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  # GET /my_products
  def my_products
    @products = @current_user.products
    render json: @products, status: :ok
  end

  # POST /products
  def create
    @product = @current_user.products.build(product_params)
    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /products/:id
  def update
    if @product
      if @product.update(product_params)
        render json: @product, status: :ok
      else
        render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  # DELETE /products/:id
  def destroy
    if @product
      @product.destroy
      render json: { message: 'Producto eliminado' }, status: :ok
    else
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  private

  def set_product
    @product = @current_user.products.find_by(id: params[:id])
    unless @product
      render json: { error: 'Product not found' }, status: :not_found
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
