import { Controller } from "@hotwired/stimulus"
import { Paginator } from "paginator"

// Connects to data-controller="pagination"
export default class extends Controller {
  static targets = ["pagination"]

  connect() {
    this.showPagination();
  }

  showPagination(event) {
    const firstDay = sessionStorage.getItem('firstDay');
    const totalDay = sessionStorage.getItem('totalDay');
    const pageId = event ? Number(event.currentTarget.id) : 0;
    const paginator = new Paginator(firstDay, totalDay, pageId);
    const startIndex = paginator.getStartIndex();
    const endIndex = paginator.getEndIndex();
    const pageTexts = paginator.generatePageTexts();

    this.removeOldDOM(this.paginationTarget);

    const ol = document.createElement('ol');
    for (let i = startIndex; i < endIndex + 1; i++) {
      const li = document.createElement("li");
      li.className = "page-item";
      li.id = i;
      li.classList.add('cursor-pointer');
      li.textContent = pageTexts[i];
      li.dataset.action = "click->page-switch#showPage click->pagination#showPagination";
      ol.appendChild(li);
    }
    this.paginationTarget.appendChild(ol);
  }

  removeOldDOM(thisTarget) {
    const parentDOM = thisTarget;
    while (parentDOM.firstChild) {
      parentDOM.removeChild(parentDOM.firstChild);
    }
  }
}
