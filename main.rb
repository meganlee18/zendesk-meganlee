require "sinatra"
require "sinatra/reloader"
require "pry"
require "httparty"

# disable :raise_errors
# disable :show_exceptions

get "/" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets.json?page=#{params[:page]}&per_page=25"

  all_tickets = call_api(url, "get")
  @tickets = all_tickets["tickets"]
  @ticket_count = all_tickets["count"]

  @num_of_pages = num_of_pages(@ticket_count)

  @page_numbers = params[:page].to_i
  @begin_id = display_starting_id(@page_numbers)
  @ending_id = display_ending_id(@page_numbers, @ticket_count)

  erb :index
end

get "/ticket/:id" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets/#{params[:id]}.json"
  all_tickets = call_api(url, "get")

  @tickets = all_tickets["ticket"]
  @ticket_id = all_tickets["ticket"]["id"]
  @date_created = all_tickets["ticket"]["created_at"]
  @requester_id = all_tickets["ticket"]["requester_id"]
  @ticket_description = all_tickets["ticket"]["description"]
  @ticket_status = all_tickets["ticket"]["status"]

  erb :ticket
end

get "/ticket/:id/update" do
  @ticket_id = params[:id]

  erb :update
end

#update individual ticket

put "/ticket/:id/update" do
  url = "https://meganlee18.zendesk.com/api/v2/tickets/#{params[:id]}.json"
  tickets = call_api(url, "put")

  # curl https://meganlee18.zendesk.com/api/v2/tickets/2.json \
  # -H "Content-Type: application/json" \
  # -d '{"ticket": {"status": "closed"}}' \
  # -v -u wylee14@gmail.com:Meganlee123 -X PUT

  redirect to("/ticket/#{params[:id]}")
end

#Search ID
get "/search" do
  url = "https://meganlee18.zendesk.com/api/v2/search.json?query=#{params[:ticket]}"
  all_tickets = call_api(url, "get")

  @tickets = all_tickets["results"]

  erb :search
end

# error do
#   @error = "Sorry, we are unable to process the request now. Please try again later."
#   erb :error
# end

private

def display_starting_id(page_num)
  ((page_num - 1) * 25) + 1
end

def display_ending_id(page_num, ticket_count)
  [page_num * 25, ticket_count].min
end

def num_of_pages(ticket_count)
  #rounds up to nearest number
  (ticket_count / 25.to_f).ceil
end

def call_api(url, method)
  begin
    #this is where errors are defined
    basic_auth = {username: "wylee14@gmail.com", password: "Meganlee123"}
    if method == "get"
      result = HTTParty.get(url, basic_auth: basic_auth)
    elsif method == "put"
      data = {
        ticket: {
          status: "#{params[:status]}".downcase,
        },
      }
      puts data

      result = HTTParty.put(url, {
        body: data.to_json,
        headers: {"Content-Type": "application/json"},
        basic_auth: basic_auth,
      })

      puts result.body
    end
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

#running one specific test instead of everything
# rspec --tag focus main_spec.rb
