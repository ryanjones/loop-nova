class SiteDecorator < Draper::Decorator
  delegate_all

  def background_color
    status = statuses.last
    return 'site-up' if status.up?
    return 'site-down' if status.down?
    ''
  end

  def status
    statuses.last.status
  end
end