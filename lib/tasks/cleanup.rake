# frozen_string_literal: true

namespace :transactions do
  desc 'Deletes transactions older than an hour'
  task cleanup: :environment do
    Transaction.where(Transaction.arel_table[:created_at].lt(1.hour.ago)).delete_all
  end
end
