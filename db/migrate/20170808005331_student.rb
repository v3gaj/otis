class Student < ActiveRecord::Migration[5.1]
  def change
  	add_column :students, :test, :string
  end
end
