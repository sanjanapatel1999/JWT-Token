class Supplier::SuppliersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_supplier, except: %i[create index]

    # GET /suppliers
    def index
      @suppliers = Supplier.all
      render json: @suppliers, status: :ok
    end
  
    # GET /suppliers/{suppliername}
    def show
      render json: @supplier, status: :ok
    end
  
    # POST /suppliers
    def create
      @supplier = Supplier.new(supplier_params)
      debugger
      if @supplier.save
        render json: @supplier, status: :created
      else
        render json: { errors: @supplier.errors.full_messages },
               status: :unprocessable_entity
      end
    end

  
    # PUT /suppliers/{suppliername}
    def update
      unless @supplier.update(supplier_params)
        render json: { errors: @supplier.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # DELETE /suppliers/{suppliername}
    def destroy
      @supplier.destroy
    end
  
    private
  
    def find_supplier
      @supplier = Supplier.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'supplier not found' }, status: :not_found
    end
  
    def supplier_params
      params.permit(:name, :username, :email, :password, :password_confirmation)
    end
end
