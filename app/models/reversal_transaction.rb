# frozen_string_literal: true

class ReversalTransaction < Transaction
  alias authorize_transaction parent

  after_save :invalidate_authorize_transaction, if: :approved?

  protected

  def skip_amount_validation?
    true
  end

  def invalidate_authorize_transaction
    authorize_transaction.update(status: :reversed)
  end
end
