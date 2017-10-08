class FetchTimelineJob < ActiveJob::Base
  def perform(*args)
    Rails.cache.write('/v1/timeline', Timeline.all)
    Rails.cache.write('/v1/post', Post.all)
  end
end
