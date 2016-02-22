class SessionsController < ApplicationController

    def new
        @user = User.new
    end

    def create
        response = User.post(:sign_in, :email => params[:session][:email], :password => params[:session][:password])
        if response.code == "200"
            response_body = JSON.parse(response.body)
            session[:auth_token] = response_body["resource"]["user"]["authentication_token"]
            session[:current_user_id] = response_body["resource"]["user"]["id"]
            redirect_to "/sessions/new"
        else
            redirect_to "/tasks"
        end
    end
end