class ApplicationSerializer
  include JSONAPI::Serializer

  def self_link
    "/v1#{super}"
  end
end
