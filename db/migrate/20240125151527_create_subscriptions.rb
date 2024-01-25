class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :title
      t.integer :price
      t.boolean :status
      t.integer :frequency
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
