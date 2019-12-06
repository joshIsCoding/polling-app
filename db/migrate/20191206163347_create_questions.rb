class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :text, null: false
      t.integer :poll_id
    end
    add_index(:questions, :poll_id)
  end
end
