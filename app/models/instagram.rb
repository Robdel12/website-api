require 'chronic'
require 'httparty'

INSTAGRAM_URL = 'https://www.instagram.com/robdel12/media/'

class Instagram < Timeline
  def initialize(attrs)
    @title = "Insta"
    @author = "robdel12"
    @url = attrs['link']
    @description = attrs['caption']['text']
    @published_date = Time.at(attrs['caption']['created_time'].to_i)

    # non-standard
    @image_url = attrs['images']['standard_resolution']['url']
  end

  def self.all
    instagram = HTTParty.get(INSTAGRAM_URL)

    instagram.parsed_response['items'].map do |item|
      new item
    end
  end
end
