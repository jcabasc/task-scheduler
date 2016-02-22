class SessionsController < ApplicationController

    def new
        @user = User.new
    end

    def create
        begin
            response = User.post(:sign_in, :email => params[:session][:email], :password => params[:session][:password])
            if response.code == "200"
                response_body = JSON.parse(response.body)
                session[:auth_token] = response_body["resource"]["user"]["authentication_token"]
                session[:current_user_id] = response_body["resource"]["user"]["id"]
            end
            redirect_to "/tasks"
        rescue ActiveResource::UnauthorizedAccess
            redirect_to "/sessions/new"
        end
    end
end