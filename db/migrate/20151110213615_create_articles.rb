class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :filename
      t.string :title
      t.string :slug
      t.text :markdown
      t.text :content
      t.string :author

      t.timestamps null: false
    end
    add_index :articles, :slug, unique: true
  end
end
