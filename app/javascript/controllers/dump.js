
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




REPLIES Controller


// Connects to data-controller="replies"
export default class extends Controller {
  connect() {
  }

  static targets = ["form", "replyForm", "replies", "viewRepliesButton", "comments"]
  static values = { count: Number }

  toggleReplies() {
    const count = this.countValue

    this.element.querySelector(".first-reply").classList.toggle("d-none");
    this.repliesTarget.classList.toggle("d-none");
    this.element.querySelector('[data-comments-target="view-replies-button"]').innerHTML =
      this.repliesTarget.classList.contains("d-none")
        ? `View all ${count} replies`
        : `Hide all ${count} replies`;
  }



  async submitReply(event) {

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
      const container = document.querySelector(".replies")
      container.insertAdjacentHTML("beforeend", commentHTML)
      form.reset()
      this.displayFlashMessage("success", "Comment/Reply created successfully");
      console.log(commentHTML)

    } else {
      console.error("Error submitting comment")
      this.displayFlashMessage("danger", "Error submitting comment");

    }

    const formDiv = event.target.closest("[data-parent-id]");
    formDiv.classList.toggle("d-none");
  }



  toggleReplyForm(event) {
    event.preventDefault();
    const parent_comment_id = event.target.getAttribute("data-parent-id");
    const form = document.querySelector(`[data-comments-target="reply-form"][data-parent-id="${parent_comment_id}"]`);
    if (form) {
      form.classList.toggle("d-none");
    } else {
      console.error("Form not found");
    }
  }




  displayFlashMessage(type, message) {
    const flashElement = document.createElement("div");
    flashElement.className = `alert alert-${type} flash`;
    flashElement.innerText = message;
    document.body.appendChild(flashElement);

    setTimeout(() => {
      flashElement.remove();
    }, 3000);
  }

}




COMMENTS
// app/javascript/controllers/comments_controller.js


export default class extends Controller {
  static targets = ["form", "replyForm", "replies", "viewRepliesButton", "comments"]


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



TOOGLE REPLY FORM


// Connects to data-controller="toggle-reply-form"
export default class extends Controller {
  connect() {
    console.log("toggleReplyForm controller connected")
  }


  static targets = ["replyForm", "viewRepliesButton"]

  toggleReplyForm(event) {
    console.log("toggleReplyForm")
    event.preventDefault();

    const replyForm = this.element.querySelector(`[data-toggle-reply-form-target="reply-form"]`);
    replyForm.classList.toggle("d-none");
  }
}
