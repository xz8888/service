json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :title, :first_name, :last_name, :phone_number, :date_in, :date_due, :date_ready, :description, :status
end
