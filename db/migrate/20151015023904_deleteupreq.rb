class Deleteupreq < ActiveRecord::Migration
  def change
    drop_table :upgrade_requests
  end
end
