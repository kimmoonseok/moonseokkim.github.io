class CreateThumnails < ActiveRecord::Migration
  def change
    create_table :thumnails do |t|
      t.string :head
      t.string :imge
      t.timestamps null: false
    end
  end
end
