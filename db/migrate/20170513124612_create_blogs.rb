class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.references :blogger, foreign_key: true
      t.string :title
      t.string :details
      t.text :content
      t.string :slug

      t.timestamps
    end
    add_index :blogs, :slug, unique: true
  end
end
