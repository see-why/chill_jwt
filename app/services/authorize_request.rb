class AuthorizeRequest < BaseService
  def initialize(headers = {})
    @headers = headers
    super()
  end

  def call
    return Response.new(nil, :unauthorized) unless decoded_auth_token

    user = User.find(id: decoded_auth_token[:user_id])
    user ? Response.new({ user: user }, nil) : Response.new(nil, :not_found)
  end

  private

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebTokenManager.decode(http_auth_token)
  end

  def http_auth_token
    scheme, token = @headers.fetch("Authorization", "")&.split
    token if scheme == "Bearer"
  end
end
