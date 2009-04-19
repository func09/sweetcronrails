require 'feed-normalizer'
require 'rfeedfinder'

class Feed < ActiveRecord::Base

  has_many :items
  
  validates_format_of :url, :with => %r{^https?://}
  validates_uniqueness_of :url, :message => 'すでに登録済みのフィードです'

  before_create :update_feed_info

  # ステータスがアクティブなフィード
  named_scope :active ,:conditions => ['status = ?','active']
  
  private
  # URLからフィードの情報を取得し、インスタンスに設定する
  def update_feed_info
    
    # フィードのURLを探す
    feed_uri = Rfeedfinder.feed(self.url)

    # フィードを取得してタイトルなどの情報を取得
    if feed_uri
      posts = FeedNormalizer::FeedNormalizer.parse(open(feed_uri), :force_parser => FeedNormalizer::SimpleRssParser)
      self.title  = posts.title
      self.url    = feed_uri
    else
      raise "feed url is not found."
    end
    
    self.icon   = ""
    self.domain = URI.parse(feed_uri).host
    self.status = "active"
    
  end
  
end
