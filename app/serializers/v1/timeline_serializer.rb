class V1::TimelineSerializer < ApplicationSerializer
  attribute :title
  attribute :author
  attribute :url
  attribute :summary
  attribute :publish_date
  # attribute :image_url

  def id
    nil
  end

  def self_link
    nil
  end

   def type
    'timeline'
  end
end
