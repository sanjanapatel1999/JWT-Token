class Customer::CartsController < ApplicationController
    def index
        @cart_items = User.find_by(params[:id]).cart.cart_items.all
        render json:@cart_items , status: :ok
    end

    def new 
        @cart_item=User.find_by(params[:id]).cart.cart_items.new
    end

    def create
        @cart_item =  User.find_by(params[:id]).cart.cart_items.where(product_id: params[:product_id])
        if @cart_item.empty? 
           @cart_item = @cart_item.new(quantity: 1,product_name:params[:product_name],description:params[:description],actual_price:params[:actual_price],current_price:params[:current_price],cart_id:params[:cart_id],product_id:params[:product_id])
           @cart_item.save
           render json: @cart_item
        else
           @cart_item.update(quantity:(@cart_item.first.quantity + 1))
           render json: @cart_item
        end
    end

    def destroy 
        @cart_item =User.find_by(params[:id]).cart.cart_items.find_by(params[:id])
        @cart_item.destroy 
        render json: "deleted sucessfully ", status: :ok
    end

    def show
        @cart_item =User.find_by(params[:id]).cart.cart_items.find_by(params[:id])
       
        render json: @cart_item
    end
   
end

