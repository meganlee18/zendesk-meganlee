require "sinatra"
require "sinatra/reloader"
require "pry"
require "httparty"

get "/" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets.json"
  result = HTTParty.get(url, :basic_auth => {username: "wylee14@gmail.com", password: "Meganlee123"})
  all_tickets = result.parsed_response
  @tickets = all_tickets["tickets"]

  erb :index
end

get "/ticket/:id" do
  erb :ticket
end
