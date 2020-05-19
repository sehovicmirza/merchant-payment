# frozen_string_literal: true

class AuthorizeTransaction < Transaction
  protected

  def skip_referenced_transaction_validation
    false
  end
end
