class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.integer :priority
      t.datetime :remind_before_at
      t.references :assignee, null: false, foreign_key: {to_table: :users}
      t.boolean :completion_status

      t.timestamps
    end
  end
end
