require "sinatra"
require "sinatra/reloader"
require "http"
require "json"


get("/") do
  @api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  @raw = HTTP.get(@api_url)
  @parsed = JSON.parse(@raw)
  @currencies_hash = @parsed.fetch("currencies")
  @currency_array = @currencies_hash.keys
  erb(:home)
end
