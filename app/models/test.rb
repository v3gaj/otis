class Test < ApplicationRecord
	has_many :relations
	has_many :careers
	accepts_nested_attributes_for :relations

	validates :indentifier, presence: true, length: { maximum: 50 }

	validates :description, length: { maximum: 255 }

	validates :time, presence: true

end
