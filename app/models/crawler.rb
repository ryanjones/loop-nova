class Crawler
  attr_accessor :site, :response

  def initialize(args = {})
    self.site = args.fetch(:site)
  end

  def crawl
    begin
      3.times do
        self.response = RestClient::Request.execute(
          method: :get,
          url: site.url,
          timeout: Rails.configuration.site_timeout,
          open_timeout: Rails.configuration.site_timeout
        )

        break if site_up?
      end
    rescue
    end
    save_status
  end

private
  def save_status
    if site_up?
      site.statuses << Status.create(status: "up")
    else
      site.statuses << Status.create(status: "down")
    end
  end

  def site_up?
    response.present? && response.code == 200
  end
end