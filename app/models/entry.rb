class Entry < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:
    Settings.content_maximum}
  validates :title, presence: true, length: {maximum:
    Settings.title_maximum}

  scope :order_entry, ->{order created_at: :desc}
end
