const DISPLAY_LENGTH = 15;

export class Paginator {
  constructor(firstDay, totalDay, currentIndex) {
    this.firstDay = firstDay;
    this.totalDay = totalDay;
    this.currentIndex = currentIndex;
  }

  generatePageTexts() {
    const pageTexts = [];
    for (let i = 0; i < this.totalDay; i++) {
      pageTexts.push(`${i + 1} / ${this.totalDay}`);
    }
    return pageTexts;
  }

  getStartIndex() {
    const headIndex = this.currentIndex - Math.floor(DISPLAY_LENGTH / 2);
    const startIndex =
      DISPLAY_LENGTH < this.totalDay && 0 < headIndex
        ? Math.min(headIndex, this.totalDay - DISPLAY_LENGTH)
        : 0;
    return startIndex;
  }

  getEndIndex() {
    const tailIndex = this.currentIndex + Math.floor(DISPLAY_LENGTH / 2);
    const lastIndex = this.totalDay - 1;
    const endIndex =
      DISPLAY_LENGTH < this.totalDay && tailIndex < lastIndex
        ? Math.max(DISPLAY_LENGTH - 1, tailIndex)
        : lastIndex;
    return endIndex;
  }
}
