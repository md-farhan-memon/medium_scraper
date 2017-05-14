class AddNextpageToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :next_page, :string, default: {}.to_json
  end
end
