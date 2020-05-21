# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      protected

      def render_json_error(error)
        if error[:type] == :activerecord
          render json: error[:value], status: :unprocessable_entity
        else
          error_object = build_error_object(error[:value])
          render json: { error: error_object }, status: error_object[:status]
        end
      end

      private

      def build_error_object(error_code)
        {}.tap do |error|
          %i[status code title].each do |field|
            error[field] = I18n.t(field, scope: "custom_errors.#{error_code}", default: nil)
          end
        end
      end
    end
  end
end
