class GithubEvent
  def initialize(attrs)
    @attrs = Map(attrs)
  end

  def self.create(attrs)
    cls = Object.const_get(attrs['type'])
    cls.new attrs
  end

  def author
    @attrs.actor.display_login
  end

  def publish_date
    @attrs.created_at
  end
end

class ForkEvent < GithubEvent
  def title
    "Forked #{@attrs.payload.forkee.name}"
  end

  def url
    @attrs.repo.url
  end

  def description
    @attrs.payload.forkee.description
  end
end

class CreateEvent < GithubEvent
  def title
    "Created #{@attrs.payload.ref_type}"
  end

  def url
    @attrs.actor.display_login
  end

  def description
    @attrs.payload.ref || @attrs.payload.description
  end
end

class PushEvent < GithubEvent
  def title
    @attrs.repo.name
  end

  def url
    first_commit.url
  end

  def description
    first_commit.message
  end

  private

  def first_commit
    @attrs.payload.commits.first
  end
end
