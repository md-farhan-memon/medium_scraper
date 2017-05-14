class CreateBloggers < ActiveRecord::Migration[5.0]
  def change
    create_table :bloggers do |t|
      t.string :user_id
      t.string :name
      t.string :username
      t.text :bio

      t.timestamps
    end
    add_index :bloggers, :user_id, unique: true
  end
end
