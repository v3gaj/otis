class Career < ApplicationRecord
  belongs_to :test

  validates_uniqueness_of :career
end
