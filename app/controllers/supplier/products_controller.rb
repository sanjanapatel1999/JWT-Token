class Supplier::ProductsController < ApplicationController
    
    def index 
        @products=Product.all
        render json: @products
    end

    def new 
        @supplier=Supplier.find_by(params[:id]).products.new
    end
    
    def create
        @supplier=Supplier.find_by(params[:id]).products.new(product_params)
        if @supplier.save 
            render json: @supplier, status: :ok 
        else 
            render json: {error: "product not created "}, status: :not_create
        end
    end 

    def show 
        @supplier=Supplier.find_by(params[:id]).products.find_by(id: params[:id])
        render json: @supplier , status: :ok
    end
    def update 
         @supplier=Supplier.find_by(params[:id]).products.find_by(id: params[:id])
        if @supplier 
            @supplier.update(product_params)
            render json: @supplier , status: :ok
        else
            render json:{ error: @supplier.errors.full_messages }, status: :unprocessable_entity
        end
    end 

    def destroy
        @supplier=Supplier.find_by(params[:id]).products.find_by(id: params[:id])
        if @supplier.destroy
            render json: "Deleted sucessfully...................", status: :ok
        else
            render json: {error: @supplier.errors.full_messages}, status: :unprocessable_entity
       
        end
    end

    private 
    def product_params 
        params.permit(:product_name,:description,:actual_price,:current_price,:supplier_id)
    end
end
