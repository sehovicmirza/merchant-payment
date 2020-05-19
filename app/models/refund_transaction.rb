# frozen_string_literal: true

class RefundTransaction < Transaction
  alias charge_transaction parent

  after_save :process, if: :approved?

  protected

  def process
    update_parent_status
    remove_from_total
  end

  private

  def update_parent_status
    charge_transaction.update(status: :refunded)
  end

  def remove_from_total
    merchant.update(total_transaction_sum: merchant.total_transaction_sum + amount)
  end
end
