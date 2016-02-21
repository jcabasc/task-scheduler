module HttpBasicAuthSupport
  extend ActiveSupport::Concern

  def authenticate_with_basic_auth
    if user = member_from_basic_auth
      @current_user = user
    else
      request_http_basic_authentication
    end
  end

  def member_from_basic_auth(&block)
    authenticate_with_http_basic do |email, password|
      a = UserAuthenticator.new(email, password)
      a.authenticate
      yield a if block_given?
      a.authenticated? ? a.resource : nil
    end
  end
end