class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    flash[:error] = "Record not found."
    redirect_to root_path
  end

  def handle_flash_error(object)
    flash.now[:error] = object.errors.full_messages.join("</br>")
    render turbo_stream: turbo_stream.update(:flash, partial: "/flash_message")
  end
end
