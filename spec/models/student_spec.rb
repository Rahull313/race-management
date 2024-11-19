require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should have_many(:lanes) }
  it { should have_many(:race_results) }
  it { should have_many(:races).through(:lanes) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe '#result_in_race' do
    let(:student) { create(:student) }
    let(:race) { create(:race, :with_students) }
    let!(:race_result) { create(:race_result, student: student, race: race) }

    context 'when the student has a result in the race' do
      it 'returns the race result for the given race' do
        expect(student.result_in_race(race.id)).to eq(race_result)
      end
    end

    context 'when the student does not have a result in the race' do
      it 'returns nil' do
        other_race = create(:race, :with_students)
        expect(student.result_in_race(other_race.id)).to be_nil
      end
    end
  end
end
