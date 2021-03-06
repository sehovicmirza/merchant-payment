# frozen_string_literal: true

module Api
  module V1
    class AuthenticatedController < ApiController
      acts_as_token_authentication_handler_for User
    end
  end
end
