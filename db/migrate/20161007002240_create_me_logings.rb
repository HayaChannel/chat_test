class CreateMeLogings < ActiveRecord::Migration[5.0]
  def change
    create_table :me_logings do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
