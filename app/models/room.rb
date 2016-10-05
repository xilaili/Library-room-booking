class Room < ApplicationRecord
    validates :room_id, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 50 }
    #validates :build, presence: true, length: { maximum: 50 }
    validates :size, presence: true
    validates :building, presence: true
end
