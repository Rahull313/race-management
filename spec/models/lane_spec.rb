require 'rails_helper'

RSpec.describe Lane, type: :model do
  let(:race) { create(:race, :with_students) }
  let(:student) { create(:student) }

  context 'validations' do
    it 'validates uniqueness of lane_number within a race' do
      create(:lane, race: race, lane_number: 3, student: student)
      duplicate_lane = build(:lane, race: race, lane_number: 1, student: student)

      expect(duplicate_lane).not_to be_valid
      expect(duplicate_lane.errors[:lane_number]).to include('Lane number must be unique for a race.')
    end

    it 'validates uniqueness of student_id within a race' do
      create(:lane, race: race, lane_number: 3, student: student)
      duplicate_student = build(:lane, race: race, lane_number: 2, student: student)

      expect(duplicate_student).not_to be_valid
      expect(duplicate_student.errors[:student_id]).to include('Student can only be assigned to one lane per race.')
    end
  end

  describe '#student_place' do
    let(:lane) { create(:lane, race: race, student: student, lane_number: 3) }

    context 'when the student has a result in the race' do
      let!(:race_result) { create(:race_result, race: race, student: student, place: 1) }

      it 'returns the student\'s place in the race' do
        expect(lane.student_place).to eq(1)
      end
    end

    context 'when the student does not have a result in the race' do
      it 'returns "NA"' do
        expect(lane.student_place).to eq('NA')
      end
    end
  end
end
