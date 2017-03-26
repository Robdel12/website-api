require 'open-uri'
require 'chronic'
MEDIUM_RSS_URL = 'https://medium.com/feed/@robdel12'

class Post < Timeline
  def initialize(attrs)
    date = attrs.pubDate.to_s
    @title = attrs.title
    @body = attrs.content_encoded.force_encoding('UTF-8')
    @author = attrs.dc_creator.force_encoding('UTF-8')
    @url = attrs.link
    @publish_date = Chronic.parse(date)
  end

  def self.all
    open(MEDIUM_RSS_URL) do |rss|
      feed = SimpleRSS.parse(rss)

      feed.entries.map { |item| new item }
    end
  end
end
