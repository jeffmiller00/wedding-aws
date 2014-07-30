json.array!(@posts) do |post|
  json.extract! post, :id, :name, :email, :message
  json.url post_url(post, format: :json)
end
