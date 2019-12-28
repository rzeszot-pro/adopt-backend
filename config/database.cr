database_name = "adopt_#{Lucky::Env.name}"

AppDatabase.configure do |settings|
  if Lucky::Env.production?
    settings.url = ENV.fetch("DATABASE_URL")
  else
    puts ENV.inspect

    settings.url = ENV["DATABASE_URL"]? || Avram::PostgresURL.build(
      database: database_name,
      hostname: ENV["POSTGRES_HOST"]? || "postgres",
      username: ENV["POSTGRES_USER"]? || "postgres",
      password: ENV["POSTGRES_PASSWORD"]? || "postgres",
      port: ENV["POSTGRES_PORT"]? || "5432"
    )
  end
end

Avram.configure do |settings|
  settings.database_to_migrate = AppDatabase

  # In production, allow lazy loading (N+1).
  # In development and test, raise an error if you forget to preload associations
  settings.lazy_load_enabled = Lucky::Env.production?

  # Uncomment the next line to log all SQL queries
  # settings.query_log_level = ::Logger::Severity::DEBUG
end
