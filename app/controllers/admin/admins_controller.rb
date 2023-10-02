class Admin::AdminsController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_admin, except: %i[create index]
  
    # GET /admins
    def index
      @admins = Admin.all
      render json: @admins, status: :ok
    end
  
    # GET /admins/{adminname}
    def show
      render json: @admin, status: :ok
    end
  
    # POST /admins
    def create
      @admin = Admin.new(admin_params) 
      if @admin.save
        render json: @admin, status: :created
      else
        render json: { errors: @admin.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # PUT /admins/{adminname}
    def update
      unless @admin.update(admin_params)
        render json: { errors: @admin.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # DELETE /admins/{adminname}
    def destroy
      @admin.destroy
    end
  
    private
  
    def find_admin
      @admin = Admin.find_by_username!(params[:_username])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'admin not found' }, status: :not_found
    end
  
    def admin_params
      params.permit(:name, :username, :email, :password, :password_confirmation)
    end
end
