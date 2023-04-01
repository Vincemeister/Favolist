import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-and-replies"
export default class extends Controller {
  connect() {
    console.log("hello from comment-and-replies controller")
  };

  static targets = ["replyformcontainer", "replyform", "replies", "viewrepliesbutton", "firstreply"]
  static values = { repliesCount: Number, commentId: Number }

  toggleReplies(event) {
    event.preventDefault();
    this.repliesTarget.classList.toggle("d-none");
    this.viewRepliesTarget.classList.toggle("d-none");
    this.firstReplyTarget.classList.toggle("d-none");
  };

  toggleReplyForm(event) {
    event.preventDefault();
    this.replyformTarget.classList.toggle("d-none");
    console.log(this.replyformTarget);
  };

  submitReply(event) {
    event.preventDefault();
    fetch(this.formTarget.action, {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
      },
      body: new FormData(this.formTarget)
    })
    .then(response => response.json())
    .then((data) => {
      if (data.inserted_item) {
        this.repliesTarget.insertAdjacentHTML("beforeend", data.inserted_item)
      }
      this.replyformTarget.outerHTML = data.form
    })
    this.toggleReplyForm
  }

  send(event) {
    // [...]

    fetch(this.formTarget.action, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.json())
      .then((data) => {
        if (data.inserted_item) {
          this.itemsTarget.insertAdjacentHTML("beforeend", data.inserted_item)
        }
        this.formTarget.outerHTML = data.form
      })
  }

}
