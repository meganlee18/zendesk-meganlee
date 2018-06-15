require "sinatra"
require "pry"
require "httparty"

disable :raise_errors
disable :show_exceptions

get "/" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets.json?page=#{params[:page]}&per_page=25"

  all_tickets = call_api(url)
  @tickets = all_tickets["tickets"]
  @ticket_count = all_tickets["count"]

  @num_of_pages = num_of_pages(@ticket_count)

  erb :index
end

get "/ticket/:id" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets/#{params[:id]}.json"
  all_tickets = call_api(url)

  @tickets = all_tickets["ticket"]
  @ticket_id = all_tickets["ticket"]["id"]
  @date_created = all_tickets["ticket"]["created_at"]
  @requester_id = all_tickets["ticket"]["requester_id"]
  @ticket_description = all_tickets["ticket"]["description"]

  erb :ticket
end

error do
  @error = "Sorry, we are unable to process the request now. Please try again later."
  erb :error
end

private

def num_of_pages(ticket_count)
  #rounds up to nearest number
  (ticket_count / 25.to_f).ceil
end

def call_api(url)
  begin
    #this is where errors are defined
    basic_auth = {username: "wylee14@gmail.com", password: "Meganlee123"}
    result = HTTParty.get(url, basic_auth: basic_auth)
    response = result.parsed_response
    if response["error"]
      raise "Error calling API"
    else
      response
    end
  rescue
    #this is where errors are being handled
    raise "Oh no! There is an error, try again later."
  end
end
