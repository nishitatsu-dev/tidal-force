import { Controller } from "@hotwired/stimulus";
import { Paginator } from "paginator";

// Connects to data-controller="pagination"
export default class extends Controller {
  static targets = ["pagination"];

  connect() {
    this.showPagination();
  }

  showPagination(event) {
    const pageId = event ? Number(event.currentTarget.id) : 0;

    this.#removeOldDOM(this.paginationTarget);
    this.#makeNewPagination(this.paginationTarget, pageId);
  }

  #removeOldDOM(thisTarget) {
    const parentDOM = thisTarget;
    while (parentDOM.firstChild) {
      parentDOM.removeChild(parentDOM.firstChild);
    }
  }

  #makeNewPagination(paginationTarget, pageId) {
    const firstDay = sessionStorage.getItem("firstDay");
    const totalDay = sessionStorage.getItem("totalDay");
    const paginator = new Paginator(firstDay, totalDay, pageId);
    const startIndex = paginator.getStartIndex();
    const endIndex = paginator.getEndIndex();
    const pageDates = paginator.getDatesAndDays().dates;
    const pageDays = paginator.getDatesAndDays().days;

    const ol = document.createElement("ol");
    ol.className = "flex flex-wrap gap-1";
    const jumpFirstButton = this.#makeButton(0, "|«");
    ol.appendChild(jumpFirstButton);
    for (let i = startIndex; i < endIndex + 1; i++) {
      const li = document.createElement("li");
      const color = this.#getColor(i, pageId, pageDays);
      li.className = `page-item relative inline-flex items-center justify-center rounded-md w-10 h-10 text-sm font-semibold ${color} ring-1 ring-gray-300 ring-inset focus:z-20 focus:outline-offset-0 cursor-pointer`;
      li.id = i;
      li.textContent = pageDates[i];
      li.dataset.action =
        "click->calc-results-page#showPage click->records-page#showPage click->pagination#showPagination";
      ol.appendChild(li);
    }
    const jumpLastButton = this.#makeButton(totalDay - 1, "»|");
    ol.appendChild(jumpLastButton);
    paginationTarget.appendChild(ol);
  }

  #getColor(i, pageId, pageDays) {
    const currentColor = "text-gray-100 bg-indigo-600";
    const sundayColor = "text-gray-100 bg-red-500 hover:bg-red-300";
    const saturdayColor = "text-gray-100 bg-blue-500 hover:bg-blue-300";
    const weekdayColor = "text-gray-900 hover:bg-gray-300";
    let color = weekdayColor;
    if (i === pageId) {
      color = currentColor;
    } else if (pageDays[i] === 0) {
      color = sundayColor;
    } else if (pageDays[i] === 6) {
      color = saturdayColor;
    }
    return color;
  }

  #makeButton(id, text) {
    const li = document.createElement("li");
    li.className = "relative inline-flex items-center justify-center rounded-md w-10 h-10 text-gray-400 ring-1 ring-gray-300 ring-inset hover:bg-gray-50 focus:z-20 focus:outline-offset-0 cursor-pointer";
    li.id = id;
    li.textContent = text;
    li.dataset.action =
      "click->calc-results-page#showPage click->records-page#showPage click->pagination#showPagination";
    return li;
  }
}
