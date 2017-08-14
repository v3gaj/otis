class Classification < ApplicationRecord

	has_many :questions

	validates :description, presence: true, length: { maximum: 25 }

end
