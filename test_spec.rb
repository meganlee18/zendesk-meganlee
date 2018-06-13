require File.dirname(__FILE__) + "/test.rb"

describe "test something" do
  it "should reverse string" do
    reverse("MNDKNDFn").should == "nageM"
  end
end
