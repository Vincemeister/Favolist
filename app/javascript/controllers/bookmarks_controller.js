import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
  static targets = ["bookmark"];

  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  toggle() {
    this.bookmarkTarget.classList.toggle("fa-light");
    this.bookmarkTarget.classList.toggle("fa-solid");
  }
}
