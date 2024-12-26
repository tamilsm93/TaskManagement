# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  respond_to :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = warden.authenticate!(auth_options)
    sign_in(user)
    otp = sent_otp(user)
 
    render json: {message: 'logged in successfully', user: user}, status: :ok
  end

  def otplogin
    user_otp = params[:otp]
    user.check_otp(otp)
  end


  def sent_otp(user)
    # user  = User.find_by(email: params[:email])
    binding.pry
    user.generate_otp
  end

  # DELETE /resource/sign_out
  def destroy
    sign_out(current_user)
    render json: {message: 'logged out successfully'}, status: :ok
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
