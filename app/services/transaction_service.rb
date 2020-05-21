# frozen_string_literal: true

class TransactionService
  TRANSACTION_TYPES = {
    authorize: AuthorizeTransaction,
    refund:    RefundTransaction,
    charge:    ChargeTransaction,
    reversal:  ReversalTransaction
  }.freeze

  def initialize(params, current_user)
    @current_user = current_user
    @params = params
    @result = { resource: nil, error: {} }
  end

  def create
    validate_params

    unless result[:error].present?
      transaction = TRANSACTION_TYPES[type].new(attributes)

      if transaction.save
        result[:resource] = transaction
      else
        result[:error] = { type: :activerecord, value: transaction.errors }
      end
    end

    result
  end

  protected

  def type
    @type ||= params[:type]&.to_sym
  end

  def attributes
    @attributes ||= params.except(:type).merge(merchant_id: current_user.merchant.id)
  end

  private

  attr_reader :result, :params, :current_user

  # TODO: Improve this
  def validate_params
    if !TRANSACTION_TYPES.keys.include?(type)
      result[:error] = { type: :custom, value: :invalid_transaction_type }
    elsif !Transaction.statuses.keys.include?(params[:status])
      result[:error] = { type: :custom, value: :invalid_transaction_status }
    end
  end
end
