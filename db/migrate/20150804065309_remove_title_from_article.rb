class RemoveTitleFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :title, :text
  end
end
