module V1
  class SessionsController < ApplicationController
    skip_before_action :authorize_request, only: %i[create]

    include Services

    def create
      result = AuthenticateUser.call(**trusted_params)

      if result.success?
        render json: { token: result.data[:token] }, status: :ok
      else
        render_error(status: result.error)
      end
    end


    private

    def trusted_params
      params.permit(:email, :password).to_h.symbolize_keys
    end
  end
end
