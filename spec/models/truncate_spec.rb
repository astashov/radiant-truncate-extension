require File.dirname(__FILE__) + '/../spec_helper'

describe "truncate_words" do
  include ActionView::Helpers::TextHelper

  it "should not truncate short contents" do
    truncate_words("hello", 10, "...").should == "hello"
  end

  it "should truncate long contents" do
    truncate_words("hello there", 5, "...").should == "..."
    truncate_words("hello there", 7, "...").should == "..."
    truncate_words("hello there", 9, "...").should == "hello..."
    truncate_words("hello there", 11, "...").should == "hello there"
    text = "Returns the KC normalization of the string by default. NFKC is considered the best normalization form for passing strings to databases and validations."
    result = "Returns the KC normalization of the string by..."
    truncate_words(text, 50, "...").should == result
  end

  it "should truncate multibyte contents" do
    truncate_words("ɦɛĺłø ŵőřļđ".chars, 9, "...").should == "ɦɛĺłø..."
    truncate_words("ɦɛĺłø ŵőřļđ".chars, 12, "...").should == "ɦɛĺłø ŵőřļđ"
  end
end