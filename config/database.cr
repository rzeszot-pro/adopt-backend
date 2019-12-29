AppDatabase.configure do |settings|
  settings.url = ENV.fetch("DATABASE_URL")
end

Avram.configure do |settings|
  settings.database_to_migrate = AppDatabase
  settings.lazy_load_enabled = Lucky::Env.production?

  settings.query_log_level = ::Logger::Severity::DEBUG unless Lucky::Env.production?
end
