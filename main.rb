require "sinatra"
require "sinatra/reloader"
require "pry"
require "httparty"

basic_auth = {username: "wylee14@gmail.com", password: "Meganlee123"}

get "/" do
  page_number = 1

  if params[:page]
    page_number = params[:page]
  end

  url = "https://meganlee18.zendesk.com/api/v2/tickets.json?page=#{page_number}&per_page=25"

  result = HTTParty.get(url, basic_auth: basic_auth)
  all_tickets = result.parsed_response
  @tickets = all_tickets["tickets"]
  @ticket_count = all_tickets["count"]

  @num_of_pages = num_of_pages(@ticket_count)

  erb :index
end

get "/ticket/:id" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets/#{params[:id]}.json"
  result = HTTParty.get(url, basic_auth: basic_auth)
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
