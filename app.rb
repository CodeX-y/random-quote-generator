require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  erb(:homepage)
end

post("/quote") do
  @category = params[:genre]
  api_url = "https://api.api-ninjas.com/v1/quotes?category=#{@category}"
  puts "API URL: #{api_url}"  # Debugging
  response = HTTP.headers(:'X-Api-Key' => ENV['API_NINJA_KEY']).get(api_url)
  puts "Response Body: #{response.body}"  # Debugging
  @api_key = ENV['API_NINJA_KEY']
  @quotes = JSON.parse(response.body)
  puts "Quotes: #{@quotes}"  # Debugging
  erb(:quote)
end

post("/") do
  "Hello World!"
end
