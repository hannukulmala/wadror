class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships, if_not_exists: true do |t|
      t.integer :beer_club_id
      t.integer :user_id

      t.timestamps
    end
  end
end
