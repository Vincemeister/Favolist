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

  async submitForm(event) {
    event.preventDefault()

    const form = this.formTarget
    const data = new FormData(form)
    const response = await fetch(form.action, {
      method: form.method,
      body: data,
      headers: {
        'X-CSRF-Token': document.querySelector('[name="csrf-token"]').content
      },
      credentials: 'same-origin'
    })

    if (response.ok) {
      const commentHTML = await response.text()
      const container = document.querySelector(".container.bg-white.my-0.py-2")
      container.insertAdjacentHTML("beforeend", commentHTML)
      form.reset()
    } else {
      console.error('Error submitting comment')
    }
  }
}
