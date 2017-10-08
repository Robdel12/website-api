class V1::PostSerializer < ApplicationSerializer
  attribute :title
  attribute :url
  attribute :post_slug
  attribute :published_date
  attribute :body
  attribute :is_medium

  def id
    nil
  end

  def self_link
    nil
  end

   def type
     object.class.to_s.downcase
  end
end
