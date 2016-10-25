class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.string :access_token
      t.datetime :expires_at
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
