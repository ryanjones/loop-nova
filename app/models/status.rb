class Status < ActiveRecord::Base
  belongs_to :site
  enum status: [ :up, :down ]

  scope :recent, -> { order(created_at: :desc).first(10) }

  validates :status, presence: true
end
