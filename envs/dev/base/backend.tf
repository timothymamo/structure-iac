terraform {
    backend "gcs" {
        bucket = "dev-tfstate"
        prefix = "base"
    }
}