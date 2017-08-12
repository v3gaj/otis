class Answer < ActiveRecord::Migration[5.1]
  def change
  	add_column :answers, :content, :string
  	add_column :answers, :message, :string
  end
end
