class V1::TimelineController < ApplicationController
  def index
    render json: V1::TimelineSerializer.serialize(timeline, is_collection: true)
  end

  private

  def timeline
    limit = params[:limit] || cached_timeline.length

    cached_timeline.select(&by_type).take(limit.to_i)
  end

  def cached_timeline
    Rails.cache.read('/v1/timeline')
  end

  # filter by timeline type.
  def by_type
    filter(:type) do |timeline, type|
      timeline.artifact_type.casecmp(type).zero?
    end
  end

  def filter(param_name)
    param = params[param_name]

    if param
      ->(timeline) { yield timeline, param }
    else
      proc { true }
    end
  end
end
