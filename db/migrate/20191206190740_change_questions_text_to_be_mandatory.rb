class ChangeQuestionsTextToBeMandatory < ActiveRecord::Migration[6.0]
  def change
    change_column :questions, :text, :text, null: false
  end
end
