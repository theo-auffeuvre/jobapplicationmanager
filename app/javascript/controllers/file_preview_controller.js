import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "preview" ]

  change(event) {
    this.previewTarget.src = URL.createObjectURL(event.target.files[0])
  }
}
