/**
 * Contains functionalities for admin dashboard
 */

// Fetches data from the UserInfo table and displays it.
async function fetchAndDisplayUsers() {
    const tableElement = document.getElementById('userTable');
    const tableBody = tableElement.querySelector('tbody');

    const response = await fetch('/get-table/userinfo', {
        method: 'GET'
    });

    const responseData = await response.json();
    const userTableContent = responseData.data;

    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    userTableContent.forEach(user => {
        const row = tableBody.insertRow();
        user.forEach((field, index) => {
            const cell = row.insertCell(index);
            cell.textContent = field;
        });
    });
}


// Inserts new user into the UserInfo table.
async function insertUser(event) {
    event.preventDefault();

    const userId = document.getElementById('insertId').value;
    // const userType = document.getElementById('insertName').value; 
    const userType = '2'; // only new contributor
    const email = document.getElementById('insertEmail').value;
    const name = document.getElementById('insertName').value;
    const birthday = document.getElementById('insertBirthday').value;
    const weight = document.getElementById('insertWeight').value;
    const height = document.getElementById('insertHeight').value;

    const response = await fetch('/insert-user', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            userId: userId,
            userType: userType,
            email: email,
            name: name,
            birthday: birthday,
            weight: weight,
            height: height
        })
    });

    const responseData = await response.json();
    const messageElement = document.getElementById('insertUserResult');

    if (responseData.success) {
        messageElement.textContent = "User inserted successfully!";
        fetchAndDisplayUsers();
    } else {
        messageElement.textContent = "Error inserting user!";
    }
}


// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    fetchAndDisplayUsers();

    document.getElementById("insertUser").addEventListener("submit", insertUser);
};