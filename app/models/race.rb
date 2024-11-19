class Race < ApplicationRecord
  has_many :lanes, dependent: :destroy, inverse_of: :race
  has_many :students, through: :lanes
  has_many :race_results, dependent: :destroy

  validates :name, presence: true
  validate :minimum_two_students, :validate_unique_students_in_race,
   :validate_unique_lane_number_in_race
  accepts_nested_attributes_for :lanes
  accepts_nested_attributes_for :race_results

  private

  def minimum_two_students
    errors.add(:base, "A race must have at least 2 students.") if lanes.size < 2
  end

  # Custom validation to ensure no duplicate students in the race
  def validate_unique_students_in_race
    student_ids = lanes.map(&:student_id)
    if student_ids.uniq.size != student_ids.size
      errors.add(:lanes, "Different students cannot be assigned to the same lane")
    end
  end

  # Custom validation to ensure no duplicate lane number in the race
  def validate_unique_lane_number_in_race
    lane_numbers = lanes.map(&:lane_number)
    if lane_numbers.uniq.size != lane_numbers.size
      errors.add(:lanes, "Lane number must be unique for a race.")
    end
  end
end
