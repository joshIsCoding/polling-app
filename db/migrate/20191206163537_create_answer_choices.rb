class CreateAnswerChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_choices do |t|
      t.text :answer_text, null: false
      t.integer :question_id
    end
    add_index(:answer_choices, :question_id)
  end
end
