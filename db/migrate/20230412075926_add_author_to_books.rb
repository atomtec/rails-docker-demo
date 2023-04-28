class AddAuthorToBooks < ActiveRecord::Migration[5.0]
  def change
    add_reference :books, :author
  end
end
