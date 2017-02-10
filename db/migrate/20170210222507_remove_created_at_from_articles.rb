class RemoveCreatedAtFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :created_at, :time
  end
end
