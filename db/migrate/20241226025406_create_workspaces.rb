class CreateWorkspaces < ActiveRecord::Migration[6.1]
  def change
    create_table :workspaces do |t|
      t.string :name
      t.text :url
      t.string :api_key
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
