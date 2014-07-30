class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :invited_guest_name
      t.boolean :plus_one
      t.string :plus_one_name

      t.integer :num_beef
      t.integer :num_chicken
      t.integer :num_veg
      t.boolean :declined
      t.string :meal
      t.text :notes

      t.timestamps
    end
  end
end
