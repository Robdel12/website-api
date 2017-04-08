require 'chronic'
require 'httparty'
require 'github_event'

GITHUB_API_URL = 'https://api.github.com/users/robdel12/events'

class Github < Timeline
  def initialize(attrs)
    event = GithubEvent.create(attrs)
    @title = event.title
    @author = event.author
    @url = unwrap_url(event.url)
    @description = event.description
    @publish_date = event.publish_date
  end

  def self.all
    github = HTTParty.get(GITHUB_API_URL)
    supported_events = github.parsed_response.select do |item|
      case item['type']
      when 'CreateEvent', 'ForkEvent', 'PushEvent'
        true
      end
    end

    supported_events.map do |item|
      new item
    end
  end

  def unwrap_url(url)
    url.gsub('api.', '').gsub('/repos', '')
  end
end
