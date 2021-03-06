class Timeline
  attr_reader :title, :url, :published_date, :author, :image_url, :description

  def self.all
    timeline = Post.all # + Instagram.all + Podcast.all
    timeline.sort_by(&:published_date).reverse
  end

  def artifact_type
    self.class.name.downcase
  end
end
