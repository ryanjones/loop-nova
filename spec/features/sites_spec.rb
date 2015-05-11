feature "Sites" do
  feature "display site status" do
    let(:create_example_com) { Site.find_or_create_by(url: 'example.com') }
    let(:create_example_org) { Site.find_or_create_by(url: 'example.org') }
    let(:site_up) do
      site = create_example_com
      allow(RestClient::Request).to receive(:execute) { OpenStruct.new(code: 200) }
      Crawler.new(site: site).crawl
    end
    let(:site_down) do
      site = create_example_org
      allow(RestClient::Request).to receive(:execute) { OpenStruct.new(code: 404) }
      Crawler.new(site: site).crawl
    end

    let(:site_up_and_down) do
      site = create_example_com
      allow(RestClient::Request).to receive(:execute) { OpenStruct.new(code: 404) }
      Crawler.new(site: site).crawl
      Crawler.new(site: site).crawl
      Crawler.new(site: site).crawl
      allow(RestClient::Request).to receive(:execute) { OpenStruct.new(code: 200) }
      Crawler.new(site: site).crawl
    end

    scenario "the site is up" do
      site_up
      visit root_path
      expect(page).to have_text("example.com")
      expect(page).to have_text("up")
    end

    scenario "the site is down" do
      site_down
      visit root_path
      expect(page).to have_text("example.org")
      expect(page).to have_text("down")
    end

    scenario "one site up and one site down" do
      site_down
      site_up
      visit root_path
      expect(page).to have_text("example.com")
      expect(page).to have_text("up")
      expect(page).to have_text("example.org")
      expect(page).to have_text("down")
    end

    scenario "site up with multiple statuses" do
      site_up_and_down
      visit root_path
      expect(page).to have_text("example.com")
      expect(page).to have_text("up")
    end
  end
end