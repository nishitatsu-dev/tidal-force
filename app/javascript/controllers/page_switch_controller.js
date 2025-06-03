import { Controller } from "@hotwired/stimulus";
import { CalcResultsPage } from "calc_results_page";
import { RecordsPage } from "records_page";

// Connects to data-controller="page-switch"
export default class extends Controller {
  static targets = ["calcResultsTbody", "pageField", "pageForm"];

  connect() {
    this.showPage();
  }

  showPage(event) {
    const pageId = event ? Number(event.currentTarget.id) : 0;

    const recordsPage = new RecordsPage(
      this.pageFieldTarget,
      this.pageFormTarget,
    );
    recordsPage.getRecords(pageId);

    this.removeOldDOM(this.calcResultsTbodyTarget);
    const calcResultsPage = new CalcResultsPage(this.calcResultsTbodyTarget);
    calcResultsPage.makeNewTable(pageId);
  }

  removeOldDOM(thisTarget) {
    const parentDOM = thisTarget;
    while (parentDOM.firstChild) {
      parentDOM.removeChild(parentDOM.firstChild);
    }
  }
}
