require 'rails_helper'

RSpec.describe Race, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }

    it 'is invalid if it has fewer than 2 race lanes' do
      race = build(:race)
      race.lanes.build(student: create(:student))

      expect(race).not_to be_valid
      expect(race.errors[:base]).to include('A race must have at least 2 students.')
    end

    it 'is valid with 2 or more race lanes' do
      race = build(:race)
      race.lanes.build(student: create(:student), lane_number: 1)
      race.lanes.build(student: create(:student), lane_number: 2)

      expect(race).to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:lanes).dependent(:destroy) }
    it { should have_many(:students).through(:lanes) }
    it { should have_many(:race_results).dependent(:destroy) }
  end

  describe 'custom validations' do
    it 'does not allow duplicate students in the same race' do
      student = create(:student)
      race = build(:race, lanes_attributes: [
        { lane_number: 1, student: student },
        { lane_number: 2, student: student }
      ])
      expect(race).not_to be_valid
      expect(race.errors[:lanes]).to include('Different students cannot be assigned to the same lane')
    end

    it 'does not allow duplicate lane number in the same race' do
      race = build(:race, lanes_attributes: [
        { lane_number: 1, student: create(:student) },
        { lane_number: 1, student: create(:student) }
      ])
      expect(race).not_to be_valid
      expect(race.errors[:lanes]).to include('Lane number must be unique for a race.')
    end
  end
end
