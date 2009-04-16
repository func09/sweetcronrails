require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Feed do
  before(:each) do
    @valid_attributes = {
      :title  => "title",
      :domain => "www.example.com",
      :url    => "http://www.example.com/index.rss",
      :icon   => "http://www.example.com/favicon.ico",
      :status => "active",
    }
  end

  #it "should create a new instance given valid attributes" do
  #  Feed.create!(@valid_attributes)
  #end

  it "#url が空の時は、保存に失敗するべき" do
    feed = Feed.create(@valid_attributes.merge({:url => ""}))
    feed.should have(1).errors_on(:url)
  end

  it "#url がhttp://で始まらない時、保存に失敗するべき" do
    feed = Feed.create(@valid_attributes.merge({:url => "ftp://ftp.example.com"}))
    feed.should have(1).errors_on(:url)
  end

  it "#url はhttp://で始まるURLの形式であるとき、保存に成功する" do
    feed = Feed.create(@valid_attributes.merge({:url => "http://www.example.com"}))
    feed.should have(0).errors_on(:url)
  end
  
end
