class Lane < ApplicationRecord
  belongs_to :race, inverse_of: :lanes
  belongs_to :student

  validates :lane_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :lane_number, uniqueness: { scope: :race_id, message: "Lane number must be unique for a race." }
  validates :student_id, uniqueness: { scope: :race_id, message: "Student can only be assigned to one lane per race." }

  validates_associated :race

  def student_place
    student&.result_in_race(race.id)&.place || 'NA'
  end
end