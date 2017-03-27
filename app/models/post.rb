require 'open-uri'
require 'chronic'
require 'html_truncator'

MEDIUM_RSS_URL = 'https://medium.com/feed/@robdel12'
SUMMARY_LENGTH_IN_WORDS = 20

class Post < Timeline
  def initialize(attrs)
    date = attrs.pubDate.to_s
    summary = HTML_Truncator.truncate(attrs.content_encoded.force_encoding('UTF-8'), SUMMARY_LENGTH_IN_WORDS)

    @title = attrs.title
    @description = summary
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
