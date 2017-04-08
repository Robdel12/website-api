namespace :timeline do
  task :cache => :environment do
    FetchTimelineJob.new.perform
  end
end
