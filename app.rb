require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  erb(:homepage)
end

post("/quote") do
  @category = params["genre"]
  @api_key = ENV['API_NINJA_KEY']

  if @api_key.nil? || @api_key.empty?
    puts "API key is missing."
    return "API key is missing. Please set the API_NINJA_KEY environment variable."
  end

  api_url = "https://api.api-ninjas.com/v1/quotes?category=#{@category}"
  puts "API URL: #{api_url}"  # Debugging

  begin
    response = HTTP.headers(:'X-Api-Key' => @api_key).get(api_url)
    puts "Response Status: #{response.status}"  # Debugging
    puts "Response Body: #{response.body}"  # Debugging

    if response.status.success?
      @quotes = JSON.parse(response.body)
      erb(:quote)
    else
      puts "Failed to fetch quotes: #{response.status} - #{response.body}"
      return "Failed to fetch quotes. Please try again later."
    end
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
    return "An internal error occurred. Please try again later."
  end
end

post("/") do
  "Hello World!"
end
