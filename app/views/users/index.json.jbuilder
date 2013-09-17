json.array!(@users) do |user|
  json.extract! user, :name, :email, :password, :username_string
  json.url user_url(user, format: :json)
end
