class CreateFormulas < ActiveRecord::Migration[5.2]
  def change
    create_table :formulas do |t|
      t.string :data
      t.references :templates, foreign_key: true

      t.timestamps
    end
  end
end
