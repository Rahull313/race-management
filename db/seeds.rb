STUDENT_NAMES = %w[
  Alice\ Johnson Bob\ Smith Charlie\ Brown David\ Lee Emma\ Wilson
  Frank\ Miller Grace\ Davis Hannah\ Clark Ian\ Moore Jack\ Taylor
]

STUDENT_NAMES.each do |student_name|
  Student.create!(name: student_name)
end
