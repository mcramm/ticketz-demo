class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :seat, null: false, foreign_key: true
      t.references :showtime, null: false, foreign_key: true
      t.references :customer, null: true, foreign_key: true
      t.integer :status, null: false

      t.timestamps
    end
  end
end
