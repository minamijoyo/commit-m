class AddFulltextIndexToCommit < ActiveRecord::Migration
  def change
    add_index :commits, :message, type: :fulltext
  end
end
