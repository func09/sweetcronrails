require 'thread'
require 'feed-normalizer'
module SweetCron

  # フィードの内容を収集するクラス
  class Crawler

    MAX_WORKERS_SIZE = 1
    
    def initialize(logger)
      @logger = logger || Logger.new
    end

    # クローラーをスタートする
    def start
      
      queue = Queue.new

      Feed.active.each do |feed|
        queue.push Proc.new {
          
          logger.info "= #{feed.id}のクロールの巡回をスタート"
          res = FeedNormalizer::FeedNormalizer.parse(open(feed.url))
          logger.debug "- #{res.title}"
          logger.debug "- #{res.description}"
          logger.debug "- #{res.last_updated}"
          logger.debug "- #{res.author}"
          logger.debug "- #{res.url}"
          logger.debug "- #{res.items.size}"

          res.items.each do |item|
            logger.debug "-- #{item.title}"
            logger.debug "-- #{item.content.slice(0,30)}"
            logger.debug "-- #{item.id}"
            logger.debug "-- #{item.url}"
            logger.debug "-- #{item.author}"
            logger.debug "-- #{item.categories}"
            logger.debug "-- #{item.date_published.to_s(:short)}"
            logger.debug ""
          end
          
          logger.info "#{feed.id}のクロールの巡回を終了"
          logger.info "====================================="

        }
      end

      workers = []
      MAX_WORKERS_SIZE.times do
        workers << Thread.new do
          loop {
            queue.pop.call
            sleep 1
            Thread.exit if queue.empty?
          }
        end
      end
      
      # sleep 10
      workers.each {|t| t.join}
      
    end

    def logger
      @logger
    end
    
  end
  
end
