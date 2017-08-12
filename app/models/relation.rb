class Relation < ApplicationRecord
  belongs_to :test
  belongs_to :question

  validates :question_id, uniqueness: { scope: :test_id }
end
