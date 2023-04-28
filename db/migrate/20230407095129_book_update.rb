class BookUpdate < ActiveRecord::Migration[5.0]
  def change
    rename_column :books, :ttile, :title
  end
end
