class ErrorRenderer
  extend ActiveSupport::Concern

  MESSAGE_BY_STATUS = {
    unauthorized: {
      status_code: :unauthorized,
      payload: "UNAUTHORIZED"
    },
    not_found: {
      status_code: :not_found,
      status: MESSAGE_BY_STATUS[status][:status_code]
    }
  }

  included do
    private

    def render_error(status:, message: MESSAGE_BY_STATUS[status][:payload])
      render(
        json: { errors: message },
        status: MESSAGE_BY_STATUS[status][:status_code]
      )
    end
  end
end
