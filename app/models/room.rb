class Room < ApplicationRecord
    before_save { self.room_id = room_id.downcase }
    validates :room_id, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
    #validates :build, presence: true, length: { maximum: 50 }
    validates :size, presence: true
end
