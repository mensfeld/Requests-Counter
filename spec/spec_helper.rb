$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'requests_counter'

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => ":memory:"
)

ActiveRecord::Schema.define do
  ActiveRecord::Base.connection.create_table(:requests_counters) do |t|
    t.column :token,              :string
    t.column :resource,           :string
    t.column :attempts,           :integer, :default => 0
    t.column :available_attempts, :integer, :default => 10
    t.column :wait_time,          :string,  :default => '1h'
    t.column :last_logged,        :datetime
  end

  add_index :requests_counters, :resource
  add_index :requests_counters, :token
end

