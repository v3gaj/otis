class Student < ApplicationRecord

	attr_accessor :ans
	attr_accessor :results
	attr_accessor :classifications
	validates :name, presence: true

end
