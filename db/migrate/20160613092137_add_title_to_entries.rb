class AddTitleToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :entry_title, :string
  end
end
