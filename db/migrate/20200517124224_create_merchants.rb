# frozen_string_literal: true

class CreateMerchants < ActiveRecord::Migration[6.0]
  def change
    create_table :merchants do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.string     :name, null: false
      t.text       :description
      t.integer    :status, null: false, default: 0
      t.decimal    :total_transaction_sum, null: false, default: 0

      t.timestamps
    end
  end
end
