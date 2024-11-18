import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js";
export default class extends Controller {

  show_lanes(e) {
    e.preventDefault()

    var checkedStudents = [];
    $('input[type="checkbox"]:checked').each(function() {
      var studentId = $(this).val();
      checkedStudents.push(studentId);
    });

    $("#race_create_button").removeClass('d-none')
    $("#assinge_lane_button").remove();

    get(`/races/load_lanes?student_ids=${checkedStudents}`,{
      responseKind: 'turbo-stream'
    })
  }
}
