FactoryBot.define do
  factory :race_result do
    student
    race
    place { 1 }
  end
end
