async submitForm(event) {
  event.preventDefault();

  const form = event.target;
  const data = new FormData(form);
  const response = await fetch(this.form.action, {
    method: form.method,
    body: data,
    headers: {
      "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
    },
    credentials: "same-origin",
  })

  if (response.ok) {
    const html = await response.text();
    // Update the appropriate container with the new comment

    this.commentsTarget.insertAdjacentHTML("beforeend", html);
    form.reset();
    this.displayFlashMessage("success", "Comment/Reply created successfully");

  } else {
    console.error("Error submitting the form:", response.statusText);
    this.displayFlashMessage("danger", "Error submitting comment");

  }
}
