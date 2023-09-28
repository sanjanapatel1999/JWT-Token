class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login
  
    # POST /auth/login
  def login
    if User.find_by_email(params[:email])
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       username: @user.username }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
      
    elsif Admin.find_by_email(params[:email])
      debugger
      @admin = Admin.find_by_email(params[:email])
      if @admin&.authenticate(params[:password])
        token = JsonWebToken.encode(admin_id: @admin.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       username: @admin.username }, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  end
  
    private
  
    def login_params
      params.permit(:email, :password)
    end
  end 