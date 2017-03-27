class Timeline
  attr_reader :title, :url, :publish_date, :author, :image_url, :summary

  def self.all
    timeline = Post.all #+ Podcast.all + Github.all
    timeline.sort_by(&:publish_date).reverse
  end

  def artifact_type
    self.class.name.downcase
  end
end
