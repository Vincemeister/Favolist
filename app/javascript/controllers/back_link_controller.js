import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["link"];
  static values = { list: String, user: String };

  connect() {
    console.log("BackLinkController connected");
    this.setBackLink();
  }



  setBackLink() {
    const parentController = sessionStorage.getItem("parentController");
    let backLink;

    if (parentController === "products-index") {
      backLink = "/products";
    } else if (parentController === "lists-show") {
      backLink = `/lists/${this.listValue}`;
    } else if (parentController === "user-show") {
      backLink = `/users/${this.userValue}`;
    }

    console.log(backLink);

    if (backLink) {
      this.linkTarget.href = backLink;
    } else {
      console.log("No back link set");
    }
  }
}
