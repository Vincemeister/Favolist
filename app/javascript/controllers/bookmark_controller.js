import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="bookmark"
export default class extends Controller {
  connect() {
  }

  static targets = ["bookmarkbutton"];

  toggle(event) {
    event.preventDefault();
    const url = this.bookmarkbuttonTarget.getAttribute("href");

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
      this.bookmarkbuttonTarget.innerHTML = "<i class='fa-solid fa-circle-bookmark fa-lg'></i>";
      this.bookmarkbuttonTarget.setAttribute("href", data.unbookmark_path);
    } else if (data.action === "unbookmark") {
      this.bookmarkbuttonTarget.innerHTML = "<i class='fa-light fa-circle-bookmark fa-lg'></i>";
      this.bookmarkbuttonTarget.setAttribute("href", data.bookmark_path);
    }
  }
}
