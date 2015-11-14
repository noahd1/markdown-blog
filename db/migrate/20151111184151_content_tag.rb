class ContentTag < ActiveRecord::Migration
  def change
    create_join_table :contents, :tags do |t|
      t.index [:content_id, :tag_id]
      t.index [:tag_id, :content_id]
    end
  end
end
