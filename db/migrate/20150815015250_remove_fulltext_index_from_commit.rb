class RemoveFulltextIndexFromCommit < ActiveRecord::Migration
  def change
    remove_index :commits, :message
  end
end
