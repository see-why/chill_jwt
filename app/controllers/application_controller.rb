class ApplicationController < ActionController::API
  include ErrorRenderer
  include RequestAuthentication
end
