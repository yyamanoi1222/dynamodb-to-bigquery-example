resource "google_storage_bucket" "example" {
  name          = "dynamodb-to-bigquery-example"
  storage_class = "NEARLINE"
  location      = var.location
}

resource "google_storage_bucket_iam_member" "example" {
  bucket     = google_storage_bucket.example.name
  role       = "roles/storage.admin"
  member     = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
  depends_on = [google_storage_bucket.example]
}

resource "google_storage_bucket" "dataflow-tmp" {
  name          = "dynamodb-to-bigquery-example-dataflow-tmp"
  storage_class = "NEARLINE"
  location      = var.location
}
