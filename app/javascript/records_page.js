export class RecordsPage {
  constructor(pageFieldTarget, pageFormTarget) {
    this.pageFieldTarget = pageFieldTarget;
    this.pageFormTarget = pageFormTarget;
  }

  getRecords(pageId) {
    this.pageFieldTarget.value = pageId;
    this.pageFormTarget.requestSubmit();
  }
}
