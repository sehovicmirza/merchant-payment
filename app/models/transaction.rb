# frozen_string_literal: true

class Transaction < ApplicationRecord
  UUID_FORMAT = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/m.freeze

  enum status: %i[error approved reversed refunded]

  validates :uuid, presence: true, format: UUID_FORMAT
  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }, unless: :skip_amount_validation?
  validate  :referenced_transaction, unless: :skip_referenced_transaction_validation?
  validate  :merchant_state

  belongs_to :merchant
  belongs_to :parent, class_name: 'Transaction', foreign_key: 'parent_id', optional: true

  protected

  def skip_amount_validation?
    false
  end

  def skip_referenced_transaction_validation?
    false
  end

  private

  def referenced_transaction
    parent.present?
  end

  def merchant_state
    merchant.active?
  end
end
