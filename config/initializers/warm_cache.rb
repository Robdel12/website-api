Rails.application.config.after_initialize do
  unless Rails.env.test?
    puts "Warming Timeline cache..."
    FetchTimelineJob.new.perform
  end
end
