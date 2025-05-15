module ErrorRenderer
  extend ActiveSupport::Concern

  MESSAGE_BY_STATUS = {
    unauthorized: {
      status_code: :unauthorized,
      payload: "UNAUTHORIZED"
    },
    not_found: {
      status_code: :not_found,
      payload: "NOT_FOUND"
    }
  }.with_indifferent_access.freeze

  private_constant :MESSAGE_BY_STATUS

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
