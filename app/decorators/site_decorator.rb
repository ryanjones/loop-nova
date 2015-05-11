class SiteDecorator < Draper::Decorator
  delegate_all
  decorates_association :statuses, scope: :recent

  def background_color
    status = statuses.first
    return 'site-up' if status.up?
    return 'site-down' if status.down?
    ''
  end

  def most_recent_status
    statuses.first.status.status
  end
end