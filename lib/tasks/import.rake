# frozen_string_literal: true

require 'csv'

FILEPATH = 'lib/assets/users.csv'

namespace :import do
  desc 'Imports new merchants and admins from csv file'
  task users: :environment do
    ActiveRecord::Base.transaction do
      CSV.foreach(FILEPATH, headers: true) do |row|
        attributes = row.to_hash

        user = User.create(attributes.extract!('role', 'email', 'password'))
        Merchant.create(attributes.merge(user: user)) if user&.merchant?
      end
    end
  end
end
