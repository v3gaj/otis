class Career < ApplicationRecord
  belongs_to :test

  validates_uniqueness_of :career

  validates :career, presence: true, length: { maximum: 50 }
  
end
