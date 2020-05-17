# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    uuid { '' }
    amount { 1 }
    customer_email { 'MyString' }
    status { 1 }
    parent_id { 1 }
    type { '' }
  end
end
