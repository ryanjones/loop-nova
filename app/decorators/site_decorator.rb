class SiteDecorator < Draper::Decorator
  delegate_all
  decorates_association :statuses, scope: :recent

  def background_color
    status = statuses.last
    return 'site-up' if status.up?
    return 'site-down' if status.down?
    ''
  end

  def last_status
    statuses.last.status.status
  end
end