json.array!(@departments) do |department|
  json.extract! department, :id, :department_name
end
