require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feed do

  def create_feed params = {}
    feed = Factory.build(:feed, params)
    feed.stub!(:update_feed_info)
    feed
  end
  
  before(:each) do
    @feed = create_feed
  end

  it "#url が空の時は、保存に失敗するべき" do
    @feed.url = ""
    @feed.save
    @feed.should have(1).errors_on(:url)
  end

  it "#url がhttp://で始まらない時、保存に失敗するべき" do
    @feed.url = "ftp://ftp.example.com"
    @feed.save
    @feed.should have(1).errors_on(:url)
  end

  it "#url はhttp://で始まるURLの形式であるとき、保存に成功する" do
    @feed.url = "http://www.example.com/"
    @feed.save
    @feed.should have(0).errors_on(:url)
  end

  it "#url は他のレコードと重複していた場合、保存に失敗する" do
    @feed.save
    same_feed = create_feed
    same_feed.save
    same_feed.should have(1).errors_on(:url)
  end
  
end
