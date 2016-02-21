module Api
  module V1
    class SessionsController < BaseController
      skip_before_filter :require_user, only: [:create]

      def create
        email = params[:email]
        password = params[:password]
        login = UserAuthenticator.new(email, password)
        login.authenticate
        if login.authenticated?
          user = login.resource
          user.save
          render json: { success: true }
        else
          render json: { success: false, error: login.error }, status: 401
        end
      end

      def destroy
        @current_user.reset_authentication_token
        render json: { success: true, message: "Signed out." }
      end

    end
  end
end
