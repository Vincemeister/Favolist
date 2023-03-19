class AddDescriptionToLists < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :description, :text
  end
end
