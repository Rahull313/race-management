class RacesController < ApplicationController
  before_action :set_race, only: %w[show]

  def index
    @races = Race.all
  end

  def new
    @race = Race.new
    @students = Student.all
  end

  def create
    @race = Race.new(race_params)
    if @race.save
      redirect_to @race, notice: "Race create successfully"
    else
      handle_flash_error(@race)
    end
  end

  def show
    @race_results = @race.race_results
  end

  def load_lanes
    render turbo_stream: [
    turbo_stream.update("lanes_fields", partial: "races/lane_form", locals: { selected_students: get_students  }),
    turbo_stream.update("students_checkboxes", partial: "races/students", locals: { students: nil })
  ]
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end

  def get_students
    student_ids = params[:student_ids].split(",")
    Student.where(id: student_ids)
  end

  def race_params
    params.require(:race).permit(:name, lanes_attributes: [ :lane_number, :student_id ], race_results_attributes: [ :id, :student_id, :place, :_destroy ])
  end
end
