class ChangeDataType < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :content, :text
  end
end
