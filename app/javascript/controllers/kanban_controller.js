import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';

// Connects to data-controller="kanban"
export default class extends Controller {
  static targets = [ "form" ]

  connect() {
    const kanbanUls = document.querySelectorAll(".kanban-col");

    const initKanbanSortable = (ulElements) => {
      ulElements.forEach((ul) => {
        new Sortable(ul, {
            group: 'kanban',
            animation: 300,
            onEnd: (event) => {
              const url = `/jobs/${event.item.dataset.id}/update_status/?new_status_id=${event.to.dataset.id}&new_status_position=${event.newDraggableIndex}`;
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


}
