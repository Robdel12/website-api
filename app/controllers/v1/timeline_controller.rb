class V1::TimelineController < ApplicationController
  def index
    render json: V1::TimelineSerializer.serialize(timeline, is_collection: true)
  end

  private

  def timeline
    timeline = Timeline.all
    limit = params[:limit] || timeline.length

    timeline.select(&by_type).take(limit.to_i)
  end

  # filter by timeline type.
  def by_type
    filter(:type) do |timeline, type|
      timeline.timeline_type.casecmp(type).zero?
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
