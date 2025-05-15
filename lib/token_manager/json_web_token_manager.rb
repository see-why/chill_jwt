require "jwt"

module TokenManager
  class JsonWebTokenManager
    SECRET_KEY = Rails.application.credentials.auth_secret_key

    def self.encode(payload, exp = 24.hours.from_now)
      return unless payload.is_a? Hash

      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
      return unless token

      body = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new(body)
    rescue JWT::ExpiredSignature, JWT::DecodeError => e
      puts "unable to decode token: #{e.message}"
    end
  end
end
