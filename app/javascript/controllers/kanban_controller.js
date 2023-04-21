import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';

// Connects to data-controller="kanban"
export default class extends Controller {
  static targets = [ "form" ]

  connect() {
    console.log("Kanban controller connected!")
    const kanbanUls = document.querySelectorAll(".kanban-col");

    const initKanbanSortable = (ulElements) => {
      ulElements.forEach((ul) => {
        new Sortable(ul, {
            group: 'kanban',
            animation: 300,
            onEnd: (event) => {
              document.getElementById(`span-${event.from.dataset.id}`).innerText = event.from.getElementsByTagName("li").length;
              document.getElementById(`span-${event.to.dataset.id}`).innerText = event.to.getElementsByTagName("li").length;
              this.pluralize(document.getElementById(`span-job-${event.from.dataset.id}`), event.from.getElementsByTagName("li").length);
              this.pluralize(document.getElementById(`span-job-${event.to.dataset.id}`), event.to.getElementsByTagName("li").length);
              document.getElementById(`span-job-${event.to.dataset.id}`).innerText
              const url = `/jobs/${event.item.dataset.job}/update_status/?new_status_id=${event.to.dataset.id}&new_status_position=${event.newDraggableIndex}`;
              fetch(url, {
                method: 'PATCH',
                headers: {
                  "Accept": "text/plain",
                  "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
                }
              })
            },
        });
      });
    };

    if (kanbanUls) {
      initKanbanSortable(kanbanUls);
    }
  }

  toggleForm() {
    this.formTarget.classList.toggle('hidden');
  }

  pluralize(el, count) {
    if (count === 1) {
      el.innerText = " JOB";
    } else {
      el.innerText = " JOBS";
    }
  }

  // updateJobCount(event) {
  //   this.jobCountTarget.innerText = event.currentTarget.getElementsByTagName("li").length;
  // }


}
