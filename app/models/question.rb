class Question < ApplicationRecord

	has_attached_file :image, styles: { large: "1200x550#", thumb: "370x170#" }
	validates_attachment_content_type :image, content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/

	has_many :answers, dependent: :destroy
	has_many :relations, dependent: :destroy
	accepts_nested_attributes_for :answers

	belongs_to :classification



	validates_uniqueness_of :identifier

	validates :identifier, presence: true, length: { maximum: 25 }

	validates :question_type, presence: true

	validates :classification_id, presence: true

	validates :description, presence: true

end
