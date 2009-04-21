require 'thread'
require 'feed-normalizer'
module SweetCron

  # フィードの内容を収集するクラス
  class Crawler

    # TODO クロールするフィードの数よりWORKERの数が多いとデッドロック発生する
    MAX_WORKERS_SIZE = 3
    
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
#           logger.debug "- #{res.title}"
#           logger.debug "- #{res.description}"
#           logger.debug "- #{res.last_updated}"
#           logger.debug "- #{res.author}"
#           logger.debug "- #{res.url}"
#           logger.debug "- #{res.items.size}"

          # 取得したエントリーをループ処理
          res.entries.each do |entry|
            #logger.debug "-- title:#{entry.title}"
            #logger.debug "-- content:#{entry.content.slice(0,30)}"
            #logger.debug "-- id:#{entry.id}"
            #logger.debug "-- url:#{entry.url}"
            #logger.debug "-- author:#{entry.author}"
            #logger.debug "-- categories:#{entry.categories}"
            #logger.debug "-- published:#{entry.date_published.to_s(:short)}"
            #logger.debug ""

            item = feed.items.find_by_link(entry.url) || feed.items.build
            
            attributes = {
              :title => entry.title,
              :body => entry.content,
              :link => entry.url,
              :author => entry.author,
              :category => entry.categories.join(','),
              :modified_on => entry.date_published,
              :version => 1,
            }

            begin
              if item.new_record?
                # 新規作成
                item.attributes = attributes
                item.save
              elsif item.modified_on.to_i < entry.date_published.to_i
                # 更新
                logger.info "Update item(#{item.id}) version"
                item.attributes = attributes.merge({:version => item.version+1})
                item.save
              end
            rescue => e
              logger.error e.message
            end
            
          end
          
          logger.info "#{feed.id}のクロールの巡回を終了"

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
