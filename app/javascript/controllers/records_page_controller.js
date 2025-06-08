import { Controller } from "@hotwired/stimulus"
import { RecordsPage } from "records_page";

// Connects to data-controller="records-page"
export default class extends Controller {
  static targets = ["pageField", "pageForm"];

  pageFormTargetConnected() {
    this.showPage();
  }

  showPage(event) {
    const pageId = event ? Number(event.currentTarget.id) : 0;

    const recordsPage = new RecordsPage(
      this.pageFieldTarget,
      this.pageFormTarget,
    );
    recordsPage.getRecords(pageId);
  }
}
