class Student < ApplicationRecord

	attr_accessor :ans
	attr_accessor :results
	attr_accessor :classifications

	validates :name, presence: true, length: { maximum: 50 }

	validates :lastname, presence: true, length: { maximum: 50 }

	validates :second_lastname, presence: true, length: { maximum: 50 }

	validates :identifier, length: { maximum: 25 }

	validates :gender, presence: true, length: { maximum: 25 }

	validates :birth_date, presence: true

	validates :career, length: { maximum: 50 }

	validates :high_school, length: { maximum: 50 }

end
