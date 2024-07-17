import { Turbo } from "@hotwired/turbo-rails"
import * as ActionCable from "@rails/actioncable"
import Rails from "@rails/ujs"
Rails.start()
const cable = ActionCable.createConsumer()
Turbo.connectStreamSource(cable.subscriptions.create("Turbo::StreamsChannel"))
import * as bootstrap from "bootstrap"
import "../stylesheets/application"
