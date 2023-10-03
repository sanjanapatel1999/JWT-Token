class SearchsController < ApplicationController
  def search
    @query=params[:query]
    @products=Product.where("products.product_name LIKE ?",["%#{@query}%"])
    if @products.present?
    render json: @products, status: :ok
    else  
      render json: "Sorry, this is not available ............... "
    end
  end
end
