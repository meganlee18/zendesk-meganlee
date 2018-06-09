require "sinatra"
require "sinatra/reloader"
require "pry"
require "httparty"

get "/" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets.json?page=1&per_page=25"

  result = HTTParty.get(url, :basic_auth => {username: "wylee14@gmail.com", password: "Meganlee123"})
  all_tickets = result.parsed_response
  @tickets = all_tickets["tickets"]
  @ticket_count = all_tickets["count"]

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

#create a loop that calls the url
# first_page = 1
# last_page = 6

# while first_page < last_page
#   url = "https://meganlee18.zendesk.com/api/v2/tickets.json?page=#{first_page}&per_page=25"
#   first_page += 1
#   puts url
# end

#page_number = params[:number]

#things to do:

#1. need to define function/method for calculating how many tickets per page
#2. This means total % 5 = 0 there will be 5 pages; if remainder is 1, add another page
#3.  4 pages of 25 data each, plus one page with 1 data
#4. Pass page number into a links (index)
