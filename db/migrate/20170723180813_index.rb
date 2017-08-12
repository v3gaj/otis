class Index < ActiveRecord::Migration[5.1]
  def change
  	add_reference :questions, :classification, index: true
  end
end
