require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let!(:student) { create(:student) } # FactoryBot or manual creation

  describe "GET #index" do
    it "assigns all students to @students and renders index" do
      get :index
      expect(assigns(:students)).to eq([ student ])
      expect(response).to render_template(:index)
    end
  end

  describe "GET #new" do
    it "assigns a new student to @student" do
      get :new
      expect(assigns(:student)).to be_a_new(Student)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new student and redirects to index" do
        expect {
          post :create, params: { student: { name: "Test Student" } }
        }.to change(Student, :count).by(1)
        expect(response).to redirect_to(students_path)
      end
    end

    context "with invalid attributes" do
      it "does not create a student and renders flash message" do
        post :create, params: { student: { name: "" } }
        expect(assigns(:student).errors.full_messages).to be_present
        expect(response.body).to include("turbo-stream")
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested student to @student and renders edit" do
      get :edit, params: { id: student.id }
      expect(assigns(:student)).to eq(student)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH/PUT #update" do
    context "with valid attributes" do
      it "updates the student and redirects to index" do
        patch :update, params: { id: student.id, student: { name: "Updated Name" } }
        student.reload
        expect(student.name).to eq("Updated Name")
        expect(response).to redirect_to(students_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the student and renders flash message" do
        patch :update, params: { id: student.id, student: { name: "" } }
        expect(assigns(:student).errors.full_messages).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the student and redirects to index" do
      expect {
        delete :destroy, params: { id: student.id }
      }.to change(Student, :count).by(-1)
      expect(response).to redirect_to(students_path)
      expect(flash[:notice]).to eq("Student was successfully deleted.")
    end
  end
end
