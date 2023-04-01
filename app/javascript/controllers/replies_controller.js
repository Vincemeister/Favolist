import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="replies"
export default class extends Controller {
  connect() {
    console.log("hello from replies controller")
  }



}
