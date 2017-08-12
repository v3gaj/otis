class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.string :indentifier
      t.string :description
      t.time :time

      t.timestamps
    end
  end
end
