import { Controller } from "stimulus"
export default class extends Controller {
    static targets = ["form", "messages", "input"]
    // Submit the form via AJAX using Turbo Streams
    submit(event) {
        event.preventDefault()
        let form = this.formTarget

        // Send the form using Fetch API (Turbo will handle the response)
        fetch(form.action, {
            method: 'POST',
            body: new FormData(form),
            headers: {
                'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content
            }
        })
            .then(response => response.text())
            .then(html => {
                // Append the new message
                this.messagesTarget.insertAdjacentHTML("beforeend", html)

                // Clear the input field
                this.inputTarget.value = ""

                // Scroll to the bottom of the messages
                this.scrollToBottom()
            })
    }

    // Automatically scroll the message container to the bottom
    scrollToBottom() {
        this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }
}