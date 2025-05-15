class AuthenticateUser < BaseService
  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    user = User.find_by(email: @email)
    return Response.new(nil, :not_found) unless user
    return Response.new(nil, :unauthorized) unless user.authenticate(@password)

    token = TokenManager::JsonWebTokenManager.encode(user_id: user.id)
    Response.new({ token: token }, nil)
  end
end
