class UserAuthenticator

  attr_reader :error, :resource, :password

  Error = Struct.new :type, :message do
    def error_hash
      {
        type:    type.to_s,
        details: message
      }
    end
  end

  def initialize(email, password)
    @resource = User.find_by(email: email)
    @resource, @password   = resource, password
  end

  def authenticate(login = resource)
    @error = catch :error do
      authenticate_login!(login)
      nil
    end
  end

  def authenticated?
    error.nil?
  end

  def error_struct
    UserAuthenticator::Error
  end

  def authenticate_login!(login)
    return if login.try(:authenticate, password)
    error_message = "Your email or password is incorrect. Please check the information and try again."
    throw :error, error_struct.new(:bad_credentials, error_message)
  end

end
