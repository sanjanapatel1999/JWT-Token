class Customer::WishlistsController < ApplicationController
    def index
        @wishlist_items = User.find_by(params[:id]).wishlist.wishlist_items.all
        render json:@wishlist_items , status: :ok
    end

    def new 
        @wishlist_item=User.find_by(params[:id]).wishlist.wishlist_items.new
    end

    def create
        @wishlist_item =  User.find_by(params[:id]).wishlist.wishlist_items.where(product_id: params[:product_id])
        if @wishlist_item.empty? 
           @wishlist_item = @wishlist_item.new(product_name:params[:product_name],description:params[:description],actual_price:params[:actual_price],current_price:params[:current_price],wishlist_id:params[:wishlist_id],product_id:params[:product_id])
           @wishlist_item.save
           render json: @wishlist_item
        elsif @wishlist_item.present? 
           render json: "Already exist", status: :ok
        end
    end

    def destroy 
         @wishlist_item =User.find_by(params[:id]).wishlist.wishlist_items.find_by(params[:id])
         @wishlist_item.destroy 
         render json: "deleted sucessfully ", status: :ok
    end

    def show
        @wishlist_item =User.find_by(params[:id]).wishlist.wishlist_items.find_by(params[:id]) 
        if @wishlist_item.present?
           render json: @wishlist_item
        else 
            render json: { error:"not found "}, status: :not_found
        end
    end
   
end
