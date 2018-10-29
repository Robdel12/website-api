require 'chronic'
require 'html_truncator'

SUMMARY_LENGTH_IN_WORDS = 20

class PostNormalizer
  def initialize(attrs)
    @attrs = Map(attrs)
  end

  def self.create(attrs)
    begin
      if attrs.link
        type = 'MediumPost'
      end
    rescue
      type = 'LegacyPost'
    end

    cls = Object.const_get(type)
    cls.new attrs
  end
end

class MediumPost < PostNormalizer
  def post_slug
    @attrs.title.force_encoding('UTF-8').to_url
  end

  def title
    @attrs.title.force_encoding('UTF-8')
  end

  def published_date
    @attrs.pubDate
  end

  def body
    @attrs.content_encoded.force_encoding('UTF-8')
  end

  def link
    @attrs.link
  end

  def is_medium
    true
  end

  def description
    no_html = @attrs.content_encoded.force_encoding('UTF-8').gsub(/<\/?[^>]*>/, "")
    no_html.truncate_words(SUMMARY_LENGTH_IN_WORDS)
  end
end

class LegacyPost < PostNormalizer
  def post_slug
    @attrs.post_slug
  end

  def title
    @attrs.title
  end

  def published_date
    Chronic.parse(@attrs.published_date)
  end

  def body
    @attrs.body
  end

  def description
    @attrs.excerpt
  end

  def is_medium
    false
  end

  def link
    nil
  end
end
