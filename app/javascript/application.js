import { Turbo } from "@hotwired/turbo-rails"
import * as ActionCable from "@rails/actioncable"

const cable = ActionCable.createConsumer()
Turbo.connectStreamSource(cable.subscriptions.create("Turbo::StreamsChannel"))
