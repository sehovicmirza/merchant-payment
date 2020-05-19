# frozen_string_literal: true

class ChargeTransaction < Transaction
  alias authorize_transaction parent

  after_save :add_to_total, if: :approved?

  protected

  def add_to_total
    merchant.update(total_transaction_sum: merchant.total_transaction_sum + amount)
  end
end
