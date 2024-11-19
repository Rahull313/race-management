class RaceResult < ApplicationRecord
  belongs_to :race
  belongs_to :student

  validates :place, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :validate_places

  private

  def validate_places
    places = race.race_results.map(&:place)
    return if places.blank? || places.include?(nil)

    if has_ties?(places)
      validate_tied_places(places)
    else
      validate_consecutive_places(places)
    end
  end

  def has_ties?(places)
    places.uniq.length != places.length
  end

  def validate_tied_places(places)
    next_position = 1
    places.tally.each do |place, count|
      if place != next_position
        errors.add(:place, "with ties must skip correctly after each tie. Expected #{next_position}, but found #{place}")
        break
      end

      next_position = (place + count)
    end
  end

  def validate_consecutive_places(places)
    if places.sort != (1..places.size).to_a
      errors.add(:place, "must be consecutive with no gaps.")
    end
  end
end
