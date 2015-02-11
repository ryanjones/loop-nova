class SitesController < ApplicationController
  expose(:site)
  expose(:site_presenter) { site.decorate }
  expose(:sites)
  expose(:sites_presenter) { SiteDecorator.decorate_collection(sites) }
end
