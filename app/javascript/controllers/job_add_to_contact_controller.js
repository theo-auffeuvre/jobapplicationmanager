import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "hiddable" ]

  toggle() {
    this.hiddableTarget.toggleAttribute("hidden")
  }
  
  add(event) {
    fetch("/contact_jobs", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        contactjobs: {
          job_id: event.currentTarget.dataset.id,
          contact_id: this.hiddableTarget.dataset.id
        }
      })
    })
  }

}