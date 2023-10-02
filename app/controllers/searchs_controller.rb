class SearchsController < ApplicationController
  def search
    @query=params[:query]
    @products=Product.where("products.product_name LIKE ?",["%#{@query}%"])
    render json: @products, status: :ok
  end

end
