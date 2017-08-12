class CreateRelations < ActiveRecord::Migration[5.1]
  def change
    create_table :relations do |t|
      t.references :test, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
