import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share"
export default class extends Controller {

  static values = {
    title: String,
    url: String,
    text: String
  }

  connect() {
  }

  async share() {
    try {
      await navigator.share({
       title: this.titleValue,
       url: this.urlValue,
       text: this.textValue
      })
       alert(`Thanks for Sharing!`);
   } catch (err) {
      alert(`Couldn't share ${err}`);
   }
  }
}
