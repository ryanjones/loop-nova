class Crawler
  attr_accessor :site, :response

  def initialize(args = {})
    self.site = args.fetch(:site)
  end

  def crawl
    begin
      self.response = RestClient.get site.url
    rescue
    end

    save_status
  end

private
  def save_status
    if response.present? && response.code == 200
      site.statuses << Status.create(status: "up")
    else
      site.statuses << Status.create(status: "down")
    end
  end
end