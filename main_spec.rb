require File.dirname(__FILE__) + "/main.rb"
require "rack/test"
require "pry"
require "httparty"

set :environment, :test

#specify Sinatra app
def app
  Sinatra::Application
end

describe "ticket viewer" do
  #methods that allow the use of "get '/' "
  include Rack::Test::Methods

  it "should load the home page" do
    get "/"
    last_response.status.should == 200
    #last_response.should be_ok
  end
end

describe "ticket viewer" do
  it "should return rounded up page number based on total ticket count" do
    num_of_pages(101).should == 5
  end
end

describe "calling api error" do
  it "raises" do
    expect { raise "Error calling API" }.to raise_error(RuntimeError, "Error calling API")
  end
end

describe "calling a missing method" do
  it "raises" do
    expect { raise "Oh no! There is an error, try again later." }.to raise_error(RuntimeError, "Oh no! There is an error, try again later.")
  end
end

describe "calling a runtime error" do
  it "raises" do
    expect { raise "Sorry, we are unable to process the request now. Please try again later." }.to raise_error(RuntimeError, "Sorry, we are unable to process the request now. Please try again later.")
  end
end
