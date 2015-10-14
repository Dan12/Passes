class CreateUpgradeRequests < ActiveRecord::Migration
  def change
    create_table :upgrade_requests do |t|
      t.integer :user_id
      t.integer :admin_id
      t.integer :upgrade_type
      
      t.timestamps null: false
    end
  end
end
