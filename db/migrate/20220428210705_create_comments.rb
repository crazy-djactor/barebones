class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :name
      t.text :body
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
