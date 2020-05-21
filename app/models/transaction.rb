# frozen_string_literal: true

class Transaction < ApplicationRecord
  UUID_FORMAT = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/m.freeze

  enum status: %i[error approved reversed refunded]

  validates :uuid, presence: true, uniqueness: true, format: UUID_FORMAT
  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :amount, numericality: { only_integer: true, greater_than: 0 }, unless: :skip_amount_validation?
  validate  :referenced_transaction, unless: :skip_referenced_transaction_validation?

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
    errors.add(:parent, :required) unless parent_id.present?
    errors.add(:parent, :invalid) unless parent.present?
  end
end
