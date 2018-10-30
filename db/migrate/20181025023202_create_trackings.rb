class CreateTrackings < ActiveRecord::Migration[5.2]
  def change
    create_table :trackings do |t|
      t.string :user_name
      t.datetime :check_in
      t.datetime :check_out

      t.timestamps
    end
  end
end
