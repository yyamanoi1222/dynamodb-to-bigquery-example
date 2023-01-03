resource "google_bigquery_dataset" "example" {
  dataset_id = "example_dataset"
  location   = var.location
  project    = var.project
}

resource "google_bigquery_table" "example" {
  dataset_id = google_bigquery_dataset.example.dataset_id
  table_id   = "example"
  project    = var.project

  schema = <<EOF
[
  {
    "name": "PK",
    "type": "STRING"
  },
  {
    "name": "SK",
    "type": "STRING"
  }
]
EOF
}
