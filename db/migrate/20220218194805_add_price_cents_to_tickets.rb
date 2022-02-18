class AddPriceCentsToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :price_cents, :integer, null: false, default: 200
  end
end
