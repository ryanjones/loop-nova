class Status < ActiveRecord::Base
  belongs_to :site
  enum status: [ :up, :down ]

  validates :status, presence: true
end
