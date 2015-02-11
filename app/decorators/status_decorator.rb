class StatusDecorator < Draper::Decorator
  delegate_all

  def background_color
    return 'site-up' if self.up?
    return 'site-down' if self.down?
    ''
  end
end