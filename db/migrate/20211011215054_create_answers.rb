class CreateAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :content

      t.timestamps
      
      t.index [:user_id, :question_id], unique: true
    end
  end
end
