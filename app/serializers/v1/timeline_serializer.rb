class V1::TimelineSerializer < ApplicationSerializer
  attribute :title
  attribute :author
  attribute :url
  attribute :description
  attribute :published_date
  attribute :image_url

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
