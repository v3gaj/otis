json.extract! question, :id, :identifier, :description, :image, :question_type, :created_at, :updated_at, :classification_id
json.url question_url(question, format: :json)
