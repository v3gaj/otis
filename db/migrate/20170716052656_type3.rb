class Type3 < ActiveRecord::Migration[5.1]
  def change
  	remove_column :questions, :type
  	add_column :questions, :question_type, :string
  end
end
