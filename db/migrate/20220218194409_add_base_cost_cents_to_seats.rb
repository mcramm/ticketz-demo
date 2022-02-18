class AddBaseCostCentsToSeats < ActiveRecord::Migration[7.0]
  def change
    add_column :seats, :base_cost_cents, :integer, null: false, default: 1000
  end
end
