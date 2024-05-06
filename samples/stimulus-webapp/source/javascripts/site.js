import { Application } from "@hotwired/stimulus"

import HelloController from "./controllers/hello_controller.js"

window.Stimulus = Application.start()
Stimulus.register("hello", HelloController)
