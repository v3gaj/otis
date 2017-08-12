class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :name
      t.string :lastname
      t.string :second_lastname
      t.string :identifier
      t.string :gender
      t.date :birth_date
      t.string :career
      t.string :high_school
      t.text :answers

      t.timestamps
    end
  end
end
