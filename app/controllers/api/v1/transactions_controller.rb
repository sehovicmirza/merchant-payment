# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < AuthenticatedController
      before_action :authorize_user, only: :create

      def create
        result = transaction_service.create

        if result[:error].present?
          render_json_error result[:error]
        else
          render json: result[:resource]
        end
      end

      protected

      def transaction_service
        @transaction_service ||= TransactionService.new(permitted_params, current_user)
      end

      private

      def authorize_user
        head :unauthorized unless current_user.active_merchant?
      end

      def permitted_params
        params.permit(:uuid, :amount, :customer_email, :status, :parent_id, :type)
      end
    end
  end
end