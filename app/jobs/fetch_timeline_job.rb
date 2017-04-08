class FetchTimelineJob < ActiveJob::Base
  def perform(*args)
    Rails.cache.write('/v1/timeline', Timeline.all)
  end
end
