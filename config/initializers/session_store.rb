 #Rails.application.config.session_store :active_record_store, :key => '_otis_session'

 Rails.application.config.session_store :redis_store, servers: ["redis://127.0.0.1:6379/0/session"]