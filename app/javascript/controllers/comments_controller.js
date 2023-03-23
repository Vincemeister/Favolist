// app/javascript/controllers/comments_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  toggleReplyForm(event) {
    event.preventDefault()
    const target = event.target.getAttribute("data-target")
    const parent_comment_id = event.target.getAttribute("data-parent-id")
    const form = document.querySelector(`[data-form-target="${target}"] form`)

    form.querySelector('input[name="comment[parent_comment_id]"]').value = parent_comment_id
    this.formTarget.appendChild(form)
  }

  submitForm(event) {
    const [data, status, xhr] = event.detail
    const target = document.querySelector(`[data-comments-target="list"] [data-form-target="comments.form"]`)
    target.insertAdjacentHTML("beforebegin", xhr.response)
    event.target.reset()
  }
}
