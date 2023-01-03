resource "google_dataflow_job" "example" {
  project                 = var.project
  name                    = "example"
  template_gcs_path       = "gs://dataflow-templates/latest/Stream_GCS_Text_to_BigQuery"
  temp_gcs_location       = "${google_storage_bucket.dataflow-tmp.url}/temp"
  region                  = "us-central1"
  enable_streaming_engine = true

  parameters = {
    javascriptTextTransformGcsPath      = "${google_storage_bucket.dataflow-tmp.url}/udf/transform.js"
    javascriptTextTransformFunctionName = "main"
    JSONPath                            = "${google_storage_bucket.dataflow-tmp.url}/schema.json"
    inputFilePattern                    = "${google_storage_bucket.example.url}/**"
    outputTable                         = "${var.project}:${google_bigquery_table.example.dataset_id}.${google_bigquery_table.example.table_id}"
    bigQueryLoadingTemporaryDirectory   = "${google_storage_bucket.dataflow-tmp.url}/temp_bigquery"
  }
}
