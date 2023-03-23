import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bookmark"
export default class extends Controller {
  connect() {
    console.log("hello from bookmark controller")
  }

  static targets = ["bookmarkButton"];

  toggle(event) {
    event.preventDefault();
    const url = this.bookmarkButtonTarget.getAttribute("href");

    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
      },
      credentials: "same-origin",
    })
      .then((response) => response.json())
      .then((data) => {
        this.updateButton(data);
      });
  }

  updateButton(data) {
    if (data.action === "bookmark") {
      this.bookmarkButtonTarget.innerHTML = "<i class='fa-solid fa-circle-bookmark fa-lg'></i>";
      this.bookmarkButtonTarget.setAttribute("href", data.unbookmark_path);
    } else if (data.action === "unbookmark") {
      this.bookmarkButtonTarget.innerHTML = "<i class='fa-light fa-circle-bookmark fa-lg'></i>";
      this.bookmarkButtonTarget.setAttribute("href", data.bookmark_path);
    }
  }
}
