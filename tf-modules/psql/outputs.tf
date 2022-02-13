output "psql_link" {
  description = "The URI of the PSQL created resource"
  value       = google_sql_database_instance.psql.self_link
}

output "psql_connection" {
  description = "The connection name of the instance to be used in connection strings"
  value       = google_sql_database_instance.psql.connection_name
}

output "captain_password" {
  description = "The randomly generated password for the PSQL user captain"
  value       = random_password.password.result
}