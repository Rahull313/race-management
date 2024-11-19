class Student < ApplicationRecord
  has_many :lanes, dependent: :destroy
  has_many :race_results, dependent: :destroy
  has_many :races, through: :lanes

  validates :name, presence: true, uniqueness: true

  def result_in_race(race_id)
    race_results.find_by(race_id: race_id)
  end
end
