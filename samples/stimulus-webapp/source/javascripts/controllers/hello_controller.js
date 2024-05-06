import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message", "output"]

  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  greet() {
    console.log("Clicked Greet Button")
    this.outputTarget.textContent = `You typed: ${this.messageTarget.value}`
  }
}
