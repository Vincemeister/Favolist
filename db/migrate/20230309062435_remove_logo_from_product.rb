class RemoveLogoFromProduct < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :logo, :string
  end
end
