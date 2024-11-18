module ApplicationHelper

  def flash_class(level)
    case level
    when "notice" then "alert alert-success"
    when "error" then "alert alert-danger"
    when "alert" then "alert alert-primary"
    end
  end

  def race_heading
    @races.present? ? 'List of all Races' : 'No Race Found!'
  end
end
