class StudentsController < ApplicationController
  before_action :set_student, only: %w[edit update destroy]

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, notice: "Student created successfully"
    else
      handle_flash_error(@student)
    end
  end

  def edit; end

  def update
    if @student.update(student_params)
      redirect_to students_path, notice: "Student updated successfully"
    else
      handle_flash_error(@student)
    end
  end

  def destroy
    if @student.destroy
      redirect_to students_path, notice: "Student was successfully deleted."
    else
      handle_flash_error(@student)
    end
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name)
  end
end
