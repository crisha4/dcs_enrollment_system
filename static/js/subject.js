document.addEventListener("DOMContentLoaded", () => {
    // Handle form submission
    const subjectForm = document.getElementById('subjectForm');
    subjectForm.addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = new FormData(subjectForm);
        formData.append("subject_id", document.getElementById("subjectId").value || "");
        
        const prerequisites = Array.from(document.getElementById("prerequisite").selectedOptions).map(option => option.value);
        prerequisites.forEach(prereq => {
            formData.append("prerequisites", prereq);
        });

        fetch(subjectForm.getAttribute('action'), {
            method: "POST",
            headers: {
                "X-CSRFToken": document.querySelector('[name=csrfmiddlewaretoken]').value
            },
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload(); // Refresh page to show updates
            }else{
                console.error('Error saving subject:', data.error)
            }
        });
    });

    // Handle edit button
    document.querySelectorAll(".edit-btn").forEach(button => {
        button.addEventListener("click", () => {
            // Get data attributes from the button
            const subjectId = button.getAttribute("data-id");
            const courseCode = button.getAttribute("data-code");
            const courseTitle = button.getAttribute("data-title");
            const year = button.getAttribute("data-year");
            const semester = button.getAttribute("data-semester");
            const subjectUnitsLec = button.getAttribute("data-lec-units");
            const subjectUnitsLab = button.getAttribute("data-lab-units");
            const prerequisite = button.getAttribute("data-prerequisite");

            // Populate the form fields
            document.getElementById("subjectId").value = subjectId || ""; // Hidden input
            document.getElementById("courseCode").value = courseCode || "";
            document.getElementById("courseTitle").value = courseTitle || "";
            document.getElementById("year").value = year || "";
            document.getElementById("semester").value = semester || "";
            document.getElementById("subjectUnitsLec").value = subjectUnitsLec || "";
            document.getElementById("subjectUnitsLab").value = subjectUnitsLab || "";
            
            const prerequisiteSelect = document.getElementById("prerequisite");
            Array.from(prerequisiteSelect.options).forEach(option => {
                option.selected = false;
            });

            if (prerequisite) {
                const prereqIds = prerequisite.split(',').map(id => id.trim());
                prereqIds.forEach(id => {
                    const option = prerequisiteSelect.querySelector(`option[value="${id}"]`);
                    if (option) {
                        option.selected = true;
                    }
                });
            }
            
            document.getElementById("subjectModalLabel").textContent = "Edit Subject";
            // Open the modal
            new bootstrap.Modal(document.getElementById("subjectModal")).show();
        });
    });
    document.getElementById("addSubjectBtn").addEventListener("click", () => {
        subjectForm.reset();
        document.getElementById("subjectId").value = ""; // Hidden input
        
        const prerequisiteSelect = document.getElementById("prerequisite");
        Array.from(prerequisiteSelect.options).forEach(option => {
            option.selected = false;
        });

        document.getElementById("subjectModalLabel").textContent = "Add Subject";
    
        new bootstrap.Modal(document.getElementById("subjectModal")).show();
      });
});