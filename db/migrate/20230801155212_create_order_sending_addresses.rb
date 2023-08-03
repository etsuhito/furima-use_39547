class CreateOrderSendingAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :order_sending_addresses do |t|

      t.timestamps
    end
  end
end
