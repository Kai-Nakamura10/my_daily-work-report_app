class Report < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true
  validates :body, length: { maximum: 400 }
  validates :title, length: { maximum: 100 }
end
