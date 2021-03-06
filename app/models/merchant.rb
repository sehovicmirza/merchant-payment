# frozen_string_literal: true

class Merchant < ApplicationRecord
  enum status: %i[active inactive]

  belongs_to :user
  has_many :transactions
end
