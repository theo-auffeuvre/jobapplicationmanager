import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "deactivable", "dueto" ]

  connect() {
    console.log("TaskController connected")
  }

  toggleTask() {
    this.deactivableTargets.forEach(element => {
      element.toggleAttribute("disabled")
    });

    if (this.duetoTarget.innerHTML !== "Due to") {
      this.duetoTarget.innerHTML = "Due to"
    } else {
      this.duetoTarget.innerHTML = "End Date"
    }
  }

}
