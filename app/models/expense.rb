class Expense < ApplicationRecord
  validates :date, :concept, :amount, :category_id, :type_id, presence: true
  belongs_to :category
  belongs_to :type
end
