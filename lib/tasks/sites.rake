namespace :sites do
  desc "Query all of the sites and save the status"
  task crawl: :environment do
    Site.all.each do |s|
      Crawler.new(site: s).crawl
    end
  end
end
