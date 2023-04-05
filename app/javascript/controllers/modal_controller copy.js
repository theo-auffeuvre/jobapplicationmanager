import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  static targets = ["modal"]

  open(event) {
    event.preventDefault();

    this.modalTarget.showModal();
  }

  close(event) {
    event.preventDefault();

    this.modalTarget.close();
  }

}
