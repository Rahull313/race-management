require 'rails_helper'

RSpec.describe RaceResultsController, type: :controller do
  # Create necessary factories or test data
  let!(:race) { create(:race, :with_students) }
  let!(:students) { create_list(:student, 3) }
  let!(:race_results) { students.map { |student| create(:race_result, race: race, student: student) } }

  describe 'GET #new' do
    it 'assigns race_results for each student' do
      get :new, params: { race_id: race.id }
      expect(assigns(:race_results).map(&:student_id)).to match_array(race.students.ids)
      expect(response).to render_template(:new)
    end
  end

  # Test the `update` action
  describe 'PATCH #update' do
    let(:valid_params) do
      { race: { race_results_attributes: race_results.map { |result| { id: result.id, place: 1 } } } }
    end

    let(:invalid_params) do
      { race: { race_results_attributes: race_results.map { |result| { id: result.id, place: nil } } } }
    end

    context 'with valid params' do
      it 'updates the race and redirects to the race page' do
        patch :update, params: { race_id: race.id }.merge(valid_params)
        expect(response).to redirect_to(race_path(race))
      end
    end

    context 'with invalid params' do
      it 'does not update the race and renders the flash error' do
        patch :update, params: { race_id: race.id }.merge(invalid_params)
        expect(flash.now[:error]).to include("Race results place can't be blank")
        expect(response.body).to include('<turbo-stream action="update" target="flash">')
      end
    end
  end
end
