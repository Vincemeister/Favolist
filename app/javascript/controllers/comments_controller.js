import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "replyForm", "replies", "viewRepliesButton", "comments"]
  static values = { commentId: Number, replidId: Number }


  connect() {
    console.log("Comments controller connected")
  }



  async submitForm(event) {

    event.preventDefault()

    const form = event.target
    const data = new FormData(form)
    const response = await fetch(form.action, {
      method: form.method,
      body: data,
      headers: {
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
      credentials: "same-origin",
    })

    if (response.ok) {
      const commentHTML = await response.text()
      const container = document.querySelector(".comments")
      container.insertAdjacentHTML("beforeend", commentHTML)
      form.reset()
      this.displayFlashMessage("success", "Comment/Reply created successfully");

    } else {
      console.error("Error submitting comment")
      this.displayFlashMessage("danger", "Error submitting comment");

    }
  }


  // app/javascript/controllers/comments_controller.js
// ...
  displayFlashMessage(type, message) {
    const flashElement = document.createElement("div");
    flashElement.className = `alert alert-${type} flash`;
    flashElement.innerText = message;
    document.body.appendChild(flashElement);

    setTimeout(() => {
      flashElement.remove();
    }, 3000);
  }
// ...

}
