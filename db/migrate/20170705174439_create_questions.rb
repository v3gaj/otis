class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :identifier
      t.string :description
      t.attachment :image

      t.timestamps
    end
  end
end
