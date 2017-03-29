class GithubEvent
  attr_accessor :title, :author, :url, :description, :publish_date

  def initialize(attrs)
    # eventually I imagine these will be subclassed. I'm currently trying to
    # find a patteren between the different of github events I want to support
    case attrs['type']
    when "CreateEvent"
      @title = "Created #{attrs['payload']['ref_type']}"
      @author = attrs['actor']['display_login']
      @url = attrs['repo']['url']
      @description = attrs['payload']['ref'] || attrs['payload']['description']
      @publish_date = attrs['created_at']
    when 'ForkEvent'
      @title = "Forked #{attrs['payload']['forkee']['name']}"
      @author = attrs['actor']['display_login']
      @url = attrs['repo']['url']
      @description = attrs['payload']['forkee']['description']
      @publish_date = attrs['created_at']
    when 'PushEvent'
      first_commit = attrs['payload']['commits'].first
      @title = attrs['repo']['name']
      @author = attrs['actor']['display_login']
      @url = first_commit['url']
      @description = first_commit['message']
      @publish_date = attrs['created_at']
    end
  end
end
