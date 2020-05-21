# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApiController
      def create
        user = User.find_by_email(params[:email])

        if user&.valid_password?(params[:password])
          render json: { token: user.authentication_token }, status: :created
        else
          head :unauthorized
        end
      end

      def destroy
        current_user&.authentication_token = nil
        current_user&.save ? head(:ok) : head(:unauthorized)
      end
    end
  end
end
