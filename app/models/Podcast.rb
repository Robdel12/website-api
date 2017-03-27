require 'chronic'
require 'httparty'

FRONTSIDE_API_URL = 'https://api.frontside.io/v1/artifacts?author=robert&type=podcast'

class Podcast < Timeline
  def initialize(attrs)
    podcast = attrs['attributes']
    date = podcast['publish-date']

    @title = podcast['title']
    @description = podcast['description']
    @author = "Robert DeLuca"
    @url = podcast['url']
    @publish_date = Chronic.parse(date)
  end

  def self.all
    podcasts = HTTParty.get(FRONTSIDE_API_URL)

    podcasts.parsed_response['data'].map do |item|
      new item
    end
  end
end
