class AddLinkToBlog < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :link, :string
  end
end
