require File.dirname(__FILE__) + "/main.rb"
require "rack/test"
require "pry"
require "httparty"

#methods that allow the use of "get '/' "
include Rack::Test::Methods

set :environment, :test

#specify Sinatra app
def app
  Sinatra::Application
end

describe "index" do
  it "should load the home page" do
    get "/"
    last_response.status.should == 200
  end

  it "should return tickets" do
    get "/"
    #check api response_body
    expect(last_response.body).to include("<a href='/ticket/1'>Sample ticket: Meet the ticket</a>")
  end

  it "should change page numbers" do
    get "/?page=2"
    last_response.status.should == 200
  end

  it "should return tickets for second page" do
    get "/?page=2"
    #return tickets for page 2
    expect(last_response.body).to include("<a href='/ticket/28'>magna consequat ut ullamco magna</a>")
  end
end

describe "individual ticket details" do
  it "should load the ticket page" do
    get "/ticket/1"
    last_response.status.should == 200
    #expect(last_response).to be_ok
  end

  it "should return ticket details" do
    get "/ticket/1"
    #check api response_body
    expect(last_response.body).to include("<td>Hi Megan,\n\nEmails, chats, voicemails, and tweets are captured in Zendesk Support as tickets. Start typing above to respond and click Submit to send. To test how an email becomes a ticket, send a message to support@meganlee18.zendesk.com.\n\nCurious about what your customers will see when you reply? Check out this video:\nhttps://demos.zendesk.com/hc/en-us/articles/202341799\n</td>")
  end
end

describe "num_of_pages" do
  it "should return rounded up page number based on total ticket count" do
    num_of_pages(101).should == 5
  end
end

describe "when api is down" do
  it "raises" do
    expect { call_api("http://wrong-url.com") }.to raise_error(RuntimeError, "Oh no! There is an error, try again later.")
  end
end
