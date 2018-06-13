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
    #last_response.should be_ok
    last_response.status == "200"
  end
end
