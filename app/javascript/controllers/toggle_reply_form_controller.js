import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-reply-form"
export default class extends Controller {
  connect() {
    console.log("toggleReplyForm controller connected")
  }
}
