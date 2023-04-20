import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "hiddable" ]

  connect() {
    console.log("JobAddToDocumentController connected")
  }

  toggle() {
    this.hiddableTarget.toggleAttribute("hidden")
  }
  
  add(event) {
    fetch("/document_jobs", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        documentjobs: {
          job_id: event.currentTarget.dataset.id,
          document_id: this.hiddableTarget.dataset.id
        }
      })
    })
  }

}