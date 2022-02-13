terraform {
    backend "gcs" {
        bucket = "prd-tfstate"
        prefix = "psql"
    }
}