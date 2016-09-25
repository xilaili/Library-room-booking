class History < ApplicationRecord
    before_save { self.room_id = room_id.downcase }
    validates :room_id, presence: true, length: { maximum: 50 }
    validates :user_email, presence: true, length: { maximum: 50 }
    validates :startTime, presence: true
    validates :endTime, presence: true
end
