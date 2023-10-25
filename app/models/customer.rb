class Customer < ApplicationRecord
  validates :rfc, presence: true
  has_many :invoices
end
