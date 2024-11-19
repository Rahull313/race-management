FactoryBot.define do
  factory :race do
    name { "Race #{Faker::Number.unique.number(digits: 3)}" }
    trait :with_students do
      transient do
        students_count { 2 } # Default to 2 students
      end
      after(:build) do |race, evaluator|
        evaluator.students_count.times do |i|
          race.lanes << build(:lane, race: race, student: create(:student), lane_number: i + 1)
        end
      end
    end
  end
end
