/**
 * Contains functionalities for admin dashboard
 */


// To standardize tableId and tableName
const TABLE = {
    USERINFO: { id: 'userTable', name: 'userinfo' },
    FEEDBACK: { id: 'feedbackTable', name: 'feedback' }
}

// Fetches data from all tables and displays it.
async function fetchAndDisplayAllTables() {
    fetchAndDisplayTable(TABLE.USERINFO.id, TABLE.USERINFO.name);
}


// Fetches data from table (optional param: userId) and displays it.
async function fetchAndDisplayTable(tableId, tableName, userId) {
    const tableElement = document.getElementById(`${tableId}`);
    const tableBody = tableElement.querySelector('tbody');

    let query = `/get-table/${tableName}`;
    if (!!userId) {
        query = query.concat(`/${userId}`);
    }

    const response = await fetch(query, { method: 'GET' });
    
    const responseData = await response.json();
    const tableContent = responseData.data;

    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    tableContent.forEach(tuple => {
        const row = tableBody.insertRow();
        tuple.forEach((field, index) => {
            const cell = row.insertCell(index);
            cell.textContent = field;
        });
    });
}


// Inserts new user into the UserInfo table.
async function insertUser(event) {
    event.preventDefault();

    const userId = document.getElementById('insertId').value;
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
        fetchAndDisplayTable(TABLE.USERINFO.id, TABLE.USERINFO.name);
    } else {
        messageElement.textContent = "Error inserting user!";
    }
}


// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    fetchAndDisplayAllTables();

    document.getElementById("insertUser").addEventListener("submit", insertUser);
};