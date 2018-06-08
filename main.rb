require "sinatra"
require "sinatra/reloader"
require "pry"
require "httparty"

get "/" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets.json?page=1&per_page=25"

  while url.nil?
    # do something with the response
    # but don't dally
    console.log(url)
  end

  result = HTTParty.get(url, :basic_auth => {username: "wylee14@gmail.com", password: "Meganlee123"})
  all_tickets = result.parsed_response
  @tickets = all_tickets["tickets"]

  #https://meganlee18.zendesk.com/api/v2/tickets.json?page=2&per_page=25

  erb :index
end

get "/ticket/:id" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets/#{params[:id]}.json"
  result = HTTParty.get(url, :basic_auth => {username: "wylee14@gmail.com", password: "Meganlee123"})
  all_tickets = result.parsed_response

  @tickets = all_tickets["ticket"]
  @ticket_id = all_tickets["ticket"]["id"]
  @date_created = all_tickets["ticket"]["created_at"]
  @requester_id = all_tickets["ticket"]["requester_id"]
  @ticket_description = all_tickets["ticket"]["description"]

  erb :ticket
end
