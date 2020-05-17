# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.uuid    :uuid, null: false
      t.integer :amount, null: false
      t.string  :customer_email
      t.integer :status, null: false, default: 0
      t.integer :parent_id, foreign_key: true
      t.string  :type, null: false

      t.timestamps
    end
  end
end
