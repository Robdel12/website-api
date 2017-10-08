class V1::PostController < ApplicationController
  def index
    render json: V1::PostSerializer.serialize(post, is_collection: true)
  end

  private

  def post
    limit = params[:limit] || cached_post.length

    cached_post.take(limit.to_i).sort_by(&:published_date).reverse
  end

  def cached_post
    Rails.cache.read('/v1/post')
  end

  # filter by post type.
  # TODO
  def by_type
    filter(:type) do |post, type|
      post.post_type.casecmp(type).zero?
    end
  end

  def filter(param_name)
    param = params[param_name]

    if param
      ->(post) { yield post, param }
    else
      proc { true }
    end
  end
end
