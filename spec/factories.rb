
Factory.define :feed, :class => Feed do |f|
  f.title 'feed title'
  f.domain "www.example.com"
  f.url "http://www.example.com/index.rss"
  f.icon "http://www.example.com/favicon.ico"
  f.status "active"
end

Factory.define :item, :class => Item do |item|
  item.feed_id 1
  #item.association :feed, :factory => :feed
  item.link { 'http://www.example.com/aaa/bbb/' }
  item.title ''
  item.body 'body'
  item.author 'author'
  item.category 'sports'
  item.version 1
  item.stored_on Time.now
  item.modified_on 2.days.ago
end
