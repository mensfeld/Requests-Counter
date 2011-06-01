module MyRequestsCounter
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)

    def add_my_migration
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      source = "create_requests_counters_migration.rb"
      target = "db/migrate/#{timestamp}_create_requests_counters.rb"
      copy_file source, target
    end

    def add_initializer
      source = "requests_counter_init.rb"
      target = "config/initializers/requests_counter.rb"
      copy_file source, target
    end

  end
end


