document.addEventListener("DOMContentLoaded", () => {
  // Handle form submission
  const instructorForm = document.getElementById('instructorForm');
  instructorForm.addEventListener('submit', function (e) {
      e.preventDefault();
      const instructorData = new FormData(instructorForm);
      instructorData.append("instructor_id", document.getElementById("instructorId").value || "");

      fetch(instructorForm.getAttribute('action'), {
          method: "POST",
          headers: {
              "X-CSRFToken": "{{ csrf_token }}"
          },
          body: instructorData
      })
      .then(response => response.json())
      .then(data => {
          if (data.success) {
              location.reload(); // Refresh page to show updates
          }else{
              console.error('Error saving instructor:', data.error)
          }
      });
  });

  // Handle edit button
  document.querySelectorAll(".edit-instructor-btn").forEach(button => {
      button.addEventListener("click", () => {
          // Get data attributes from the button
          const instructorId = button.getAttribute("data-id");
          const name = button.getAttribute("data-name");
          const gender = button.getAttribute("data-gender");
          const email = button.getAttribute("data-email");
          const contact = button.getAttribute("data-contact");
          const address = button.getAttribute("data-address");

          // Populate the form fields
          document.getElementById("instructorId").value = instructorId || ""; // Hidden input
          document.getElementById("instructorName").value = name || "";
          document.querySelector(`input[name="gender"][value="${gender}"]`).checked = true;
          document.getElementById("instructorEmail").value = email || "";
          document.getElementById("instructorContact").value = contact || "";
          document.getElementById("instructorAddress").value = address || "";
          
          document.getElementById("instructorModalLabel").textContent = "Edit Instructor";
          // Open the modal
          new bootstrap.Modal(document.getElementById("instructorModal")).show();
      });
  });
  // Handle add instructor button
  document.getElementById("addInstructorBtn").addEventListener("click", () => {
    // Clear the form fields
    instructorForm.reset();
    document.getElementById("instructorId").value = ""; // Hidden input

    // Update modal title
    document.getElementById("instructorModalLabel").textContent = "Add Instructor";

    // Open the modal
    new bootstrap.Modal(document.getElementById("instructorModal")).show();
  });
});