class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :content
      t.references :post

      t.timestamps
    end
  end
end
