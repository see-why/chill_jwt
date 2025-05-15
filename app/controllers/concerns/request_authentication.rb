module RequestAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :authorize_request
    attr_reader :current_user
  end

  private

  def authorize_request
    response = AuthorizeRequest.call(request.headers)

    if response.success?
      @current_user = response.data[:user]
    else
      render_error(status: response.error)
    end
  end
end
