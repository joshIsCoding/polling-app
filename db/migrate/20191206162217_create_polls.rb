class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.text :title, null: false
      t.integer :author_id
      t.timestamps
    end
    add_index(:polls, :author_id)
  end
end
