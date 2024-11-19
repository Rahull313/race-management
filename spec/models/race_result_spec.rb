require 'rails_helper'

RSpec.describe RaceResult, type: :model do
  let(:race) { create(:race, :with_students) }
  let(:student) { create(:student) }
  subject { create(:race_result, race: race, student: student, place: 1) }

  describe 'associations' do
    it { should belong_to(:race).without_validating_presence }
    it { should belong_to(:student).without_validating_presence }
  end

  describe 'validations' do
    it { should validate_presence_of(:place) }
    it { should validate_numericality_of(:place).only_integer.is_greater_than(0) }
  end

  describe 'custom validations' do
    let(:student1) { create(:student) }
    let(:student2) { create(:student) }
    let(:student3) { create(:student) }
    it 'validates no gaps in places' do
      race_result = build(:race,
                    name: "Sample Race",
                    lanes_attributes: [
                      { lane_number: 1, student_id: race.students.first.id },
                      { lane_number: 2, student_id: race.students.second.id }
                    ],
                    race_results_attributes: [
                      { student_id: race.students.first.id, place: 1 },
                      { student_id: race.students.second.id, place: 3 }
                    ])
      expect(race_result).to_not be_valid
      expect(race_result.errors['race_results.place']).to include('must be consecutive with no gaps.')
    end

    it 'allows valid places with ties' do
      race_result = build(:race,
        name: "Sample Race",
        lanes_attributes: [
          { lane_number: 1, student_id: student1.id },
          { lane_number: 2, student_id: student2.id }
        ],
        race_results_attributes: [
          { student_id: student1.id, place: 1 },
          { student_id: student2.id, place: 1 }
        ])
      expect(race_result).to be_valid
    end

    it 'allows invalid places with ties' do
      race_result = build(:race,
        name: "Sample Race",
        lanes_attributes: [
          { lane_number: 1, student_id: student1.id },
          { lane_number: 2, student_id: student2.id },
          { lane_number: 3, student_id: student3.id }
        ],
        race_results_attributes: [
          { student_id: student1.id, place: 1 },
          { student_id: student2.id, place: 1 },
          { student_id: student3.id, place: 4 }
        ])
      expect(race_result).to_not be_valid
    end
  end
end
