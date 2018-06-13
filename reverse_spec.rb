require File.dirname(__FILE__) + "/reverse.rb"
require "rack/test"

set :environment, :test

#specify Sinatra app
def app
  Sinatra::Application
end

describe "reverse service" do
  it "should reverse the string provided" do
    reverse("Megan") == "nageM"
  end
end

describe "reverse service" do
  #methods that allow you to use "get '/' "
  include Rack::Test::Methods

  it "should load the home page" do
    get "/"
    #last_response.should be_ok
    last_response.status == "200"
  end
end
