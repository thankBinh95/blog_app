class Entry < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:
    Settings.content_maximum}
end
