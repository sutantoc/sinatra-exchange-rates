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

get ("/:cur") do
  @cur = params.fetch("cur")
  @api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  @raw = HTTP.get(@api_url)
  @parsed = JSON.parse(@raw)
  @currencies_hash = @parsed.fetch("currencies")
  @currency_array = @currencies_hash.keys
  erb(:cur)
end

get ("/:cur/:second_cur") do
  @cur = params.fetch("cur")
  @second_cur = params.fetch("second_cur")
  @api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@cur}&to=#{@second_cur}&amount=1"
  @raw = HTTP.get(@api_url)
  @parsed = JSON.parse(@raw)
  @result = @parsed.fetch("result")
  erb(:conversion)
end
