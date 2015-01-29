describe 'Crawler' do
  let(:create_site) { Site.create(url: 'example.com') }
  let(:response_500) { allow(RestClient).to receive(:get).and_return(OpenStruct.new(code: 500)) }
  let(:response_200) { allow(RestClient).to receive(:get).and_return(OpenStruct.new(code: 200)) }

  it "create a status record for a site that's up" do
    response_200
    site = create_site
    Crawler.new(site: site).crawl

    expect(site.statuses.last.status).to eq("up")
  end

  it "create a status record for a site that's down" do
    response_500
    site = create_site
    Crawler.new(site: site).crawl

    expect(site.statuses.last.status).to eq("down")
  end
end