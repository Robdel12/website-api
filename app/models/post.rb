# coding: utf-8
require 'open-uri'
require 'util/post_normalizer'

MEDIUM_RSS_URL = 'https://medium.com/feed/@robdel12'

class Post < Timeline
  attr_reader :title, :url, :published_date, :post_slug, :body, :is_medium, :description

  def initialize(attrs)
    post = PostNormalizer.create(attrs)

    @title = post.title
    @url = post.link
    @post_slug = post.post_slug
    @published_date = post.published_date
    @body = post.body
    @is_medium = post.is_medium

    # for timeline
    @description = post.description
  end

  def self.all
    old_blog = HTTParty.get('https://dry-fjord-5394.herokuapp.com/api/posts?page=1&per_post=100')

    open(MEDIUM_RSS_URL) do |rss|
      feed = SimpleRSS.parse(rss)

      feed.entries.concat(old_blog.parsed_response['posts']).map do |item|
        new item
      end
    end
  end
end
