# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    name { 'MyString' }
    description { 'MyText' }
    email { 'MyString' }
    status { 1 }
    total_transaction_sum { '9.99' }
  end
end
