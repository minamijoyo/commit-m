class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :repo_full_name
      t.string :sha
      t.text :message

      t.timestamps null: false
    end
  end
end
