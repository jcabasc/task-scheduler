module Api
  module V1
    class BaseController < ActionController::Base
      respond_to :json
      before_filter :require_user

    end
  end
end
