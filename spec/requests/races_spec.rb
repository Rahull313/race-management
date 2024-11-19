require 'rails_helper'

RSpec.describe RacesController, type: :controller do
  let(:student1) { create(:student) }
  let(:student2) { create(:student) }
  let(:race) { create(:race, :with_students) }

  describe 'GET #index' do
    it 'assigns all races to @races' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new race and all students to @race and @students' do
      get :new
      expect(assigns(:race)).to be_a_new(Race)
      expect(assigns(:students)).to include(student1, student2)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new race with valid lanes and students' do
        post :create, params: {
          race: {
            name: "Sample Race",
            lanes_attributes: [
              { lane_number: 1, student_id: student1.id },
              { lane_number: 2, student_id: student2.id }
            ],
            race_results_attributes: [
              { student_id: student1.id, place: 1 },
              { student_id: student2.id, place: 2 }
            ]
          }
        }

        expect(Race.last.name).to eq("Sample Race")
        expect(Race.last.lanes.count).to eq(2)
        expect(Race.last.lanes.map(&:student_id)).to contain_exactly(student1.id, student2.id)
        expect(response).to redirect_to(Race.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a race if there are less than two students' do
        post :create, params: {
          race: {
            name: "Sample Race",
            lanes_attributes: [
              { lane_number: 1, student_id: student1.id }
            ]
          }
        }

        expect(flash.now[:error]).to include("A race must have at least 2 students.")
        expect(response.body).to include('<turbo-stream action="update" target="flash">')
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the correct race and race results' do
      get :show, params: { id: race.id }
      expect(assigns(:race)).to eq(race)
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #load_lanes' do
    it 'renders the lanes and students Turbo Stream updates' do
      post :load_lanes, params: { student_ids: "#{student1.id},#{student2.id}" }

      expect(response.body).to include('<turbo-stream action="update" target="lanes_fields">')
      expect(response.body).to include('<turbo-stream action="update" target="students_checkboxes">')
    end
  end
end
