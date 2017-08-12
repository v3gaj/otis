class CreateCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :careers do |t|
      t.references :test, foreign_key: true
      t.string :career

      t.timestamps
    end
  end
end
