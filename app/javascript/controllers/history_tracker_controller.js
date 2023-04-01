import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { parentController: String };

  connect() {
    console.log("HistoryTrackerController connected");
    sessionStorage.setItem("parentController", this.parentControllerValue);
  }

}
