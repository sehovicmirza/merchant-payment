# frozen_string_literal: true

class User < ApplicationRecord
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[merchant admin]

  has_one :merchant, dependent: :destroy

  def active_merchant?
    merchant&.active?
  end
end
