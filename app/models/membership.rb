class Membership < ApplicationRecord
  belongs_to :client
  belongs_to :gym
  validates :gym_id, presence: true, uniqueness: { scope: :client_id }
  validates :client_id, presence: true
  validates :charge, presence: true
end
