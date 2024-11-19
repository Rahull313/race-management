class RaceResultsController < ApplicationController
  before_action :set_race

  def new
    @race_results = @race.students.map do |student|
      @race.race_results.find_or_initialize_by(student: student)
    end
  end

  def update
    if @race.update(race_params)
      redirect_to race_path(@race)
    else
      flash.now[:error] = @race.errors.full_messages.join("</br>")
      render turbo_stream: turbo_stream.update(:flash, partial: "/flash_message")
    end
  end

  private

  def set_race
    @race = Race.find(params[:race_id])
  end

  def race_params
    params.require(:race).permit(race_results_attributes: [ :id, :student_id, :place, :_destroy ])
  end
end
