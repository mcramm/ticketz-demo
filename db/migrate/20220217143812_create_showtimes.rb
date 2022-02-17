class CreateShowtimes < ActiveRecord::Migration[7.0]
  def change
    create_table :showtimes do |t|
      t.datetime :starts_at
      t.references :theatre, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
