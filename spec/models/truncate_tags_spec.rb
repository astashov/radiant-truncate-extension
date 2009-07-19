require File.dirname(__FILE__) + '/../spec_helper'

describe TruncateTags do
  
  before do
    @page = Page.create!(
      :title => 'New Page',
      :slug => 'page',
      :breadcrumb => 'New Page',
      :status_id => '100'
    )
  end
  
  it "should truncate the text to the given 'chars' length" do
    @page.should render("<r:truncate chars='400'>#{(%{This is a thousand monkeys working at a thousand typewriters. Soon, they'll have written the greatest novel known to mankind. (reads one of the typewriters) It was the best of times, it was the blurst of times?! you stupid monkey! (monkey screeches) Oh, shut up.} * 2)}</r:truncate>").as(%{This is a thousand monkeys working at a thousand typewriters. Soon, they'll have written the greatest novel known to mankind. (reads one of the typewriters) It was the best of times, it was the blurst of times?! you stupid monkey! (monkey screeches) Oh, shut up.This is a thousand monkeys working at a thousand typewriters. Soon, they'll have written the greatest novel known to mankind. (reads...})
  end
  
  it "should truncate with keeping words intact" do
    @page.should render("<r:truncate chars='10'>Something</r:truncate>").as('Something')
    @page.should render(
      "<r:truncate chars='20'>Something strange is there</r:truncate>"
    ).as('Something strange...')
    @page.should render(
      "<r:truncate>Something strange is happened here. I think I should ask Sherlok Holmes about this.</r:truncate>"
    ).as('Something strange is happened here. I think I...')
  end
  
  it "should truncate with not keeping words intact" do
    @page.should render(
      "<r:truncate keep_words_intact='false' chars='10'>Something</r:truncate>"
    ).as('Something')
    @page.should render(
      "<r:truncate keep_words_intact='false' chars='15'>Something strange is there</r:truncate>"
    ).as('Something st...')
  end
  
  it "should strip html tags" do
    @page.should render(
      "<r:truncate><div class='red'>Something</div> <ul><li>Lalala</li></ul></r:truncate>"
    ).as("Something Lalala")
    @page.should render(
      "<r:truncate strip_html='false'><div class='red'>Something</div> <ul><li>Lalala</li></ul></r:truncate>"
    ).as("<div class='red'>Something</div>...")
  end
  
  it "should strip newlines" do
    @page.should render(
      "<r:truncate><div class='red'>                       Something</div>\n\n      <ul><li>Lalala</li></ul></r:truncate>"
    ).as(" Something Lalala")
    @page.should render(
      "<r:truncate strip_newlines='false'>
         <div class='red'>                       Something</div>\n\n      
         <ul><li>Lalala</li></ul></r:truncate>"
    ).as("\n                                Something\n\n   ...")
  end
  
  it "should use different ellipses" do
    @page.should render(
      "<r:truncate chars='20' ellipses=',,,'>Something strange is there</r:truncate>"
    ).as('Something strange,,,')
  end

  
end