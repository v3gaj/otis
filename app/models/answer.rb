class Answer < ApplicationRecord

	has_attached_file :image, styles: { large: "1200x550#", thumb: "370x170#" }
	validates_attachment_content_type :image, content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)$/

 	belongs_to :question

 	 validates :value, uniqueness: { scope: :question_id, conditions: -> { where(value: true) } } 
end
