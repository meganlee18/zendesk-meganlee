require File.dirname(__FILE__) + "/main.rb"
require "rack/test"
require "pry"
require "httparty"

set :environment, :test

#specify Sinatra app
def app
  Sinatra::Application
end

describe "index" do
  #methods that allow the use of "get '/' "
  include Rack::Test::Methods

  it "should load the home page" do
    get "/"
    last_response.status.should == 200
    #last_response.should be_ok
  end

  it "should return tickets" do
    get "/"
    #check api response_body
  end

  it "should change page numbers" do
    get "/?page=2"
    last_response.status.should == 200
  end

  it "should return tickets for second page" do
    get "/?page=2"
    #return tickets
  end
end

describe "individual ticket details" do
  include Rack::Test::Methods

  it "should load the ticket page" do
    get "/ticket/1"
    last_response.status.should == 200
  end

  it "should return ticket details" do
    get "/ticket/1"
    #check api response_body
  end
end

describe "num_of_pages" do
  it "should return rounded up page number based on total ticket count" do
    num_of_pages(101).should == 5
  end
end

describe "when zendesk api return error" do
  it "raises" do
    expect { call_api("http://wrong-url.com") }.to raise_error(RuntimeError, "Oh no! There is an error, try again later.")
  end
end

describe "when api is down" do
  it "raises" do
    expect { raise "Oh no! There is an error, try again later." }.to raise_error(RuntimeError, "Error calling API")
  end
end

#how to stub HTTParty in RSPEC
