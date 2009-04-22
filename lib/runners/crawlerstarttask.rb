require 'sweetcron'
class CrawlerStartTask
  @@logger = Logger.new(File.join(RAILS_ROOT, "log", "crawler.log"))

  def self.logger
    @@logger ||= Logger.new STDOUT
  end

  def self.execute
    crawler = SweetCron::Crawler.new logger
    crawler.start
  end
end
