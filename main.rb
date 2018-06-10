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

  @num_of_pages = num_of_pages(@ticket_count)

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

private

def num_of_pages(ticket_count)
  #rounds up to nearest number
  (ticket_count / 25.to_f).ceil
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
