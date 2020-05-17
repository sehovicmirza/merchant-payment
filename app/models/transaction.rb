# frozen_string_literal: true

class Transaction < ApplicationRecord
  enum status: %i[error approved reversed refunded]
end
