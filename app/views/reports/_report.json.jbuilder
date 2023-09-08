json.extract! report, :id, :name, :number, :created_at, :updated_at
json.url report_url(report, format: :json)
