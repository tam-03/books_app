class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.integer :commentable_id
      t.string  :commentable_type
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
  end
end
