class Test < ApplicationRecord
	has_many :relations
	has_many :careers
	accepts_nested_attributes_for :relations
end
