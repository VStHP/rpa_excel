class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.string :file
      t.string :attachable_type, unique: true

      t.timestamps
    end
  end
end
