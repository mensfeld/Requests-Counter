class CreateRequestsCounters < ActiveRecord::Migration
  def self.up

    create_table :requests_counters do |t|
      t.string   :token
      t.string   :resource
      t.integer  :attempts,           :default => 0
      t.integer  :available_attempts, :default => 10
      t.string   :wait_time,          :default => '1h'
      t.datetime :last_logged
    end

    add_index :requests_counters, :resource
    add_index :requests_counters, :token

  end

  def self.down
    drop_table :requests_counters
  end
end
