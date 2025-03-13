# db/migrate/20250312000002_create_teams.rb
class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
