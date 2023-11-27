/**
 * Contains functionalities for admin dashboard
 */

// To standardize tableId and tableName
const TABLE = {
    USERINFO: { id: 'userTable', name: 'userinfo' },
    FEEDBACK: { id: 'feedbackTable', name: 'feedback' },
    JOIN_FEEDBACK: { id: 'joinFeedbackTable', name: 'join-feedback' }
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
        fetchAndDisplayAllColumns("Current Users",TABLE.USERINFO.name)
    } else {
        messageElement.textContent = "Error inserting user!";
    }
}

// Joins version/feedback/recipe to show results with feedbackRating >= X
async function joinFeedbackTable() {
    const tableElement = document.getElementById(TABLE.JOIN_FEEDBACK.id);
    const tableBody = tableElement.querySelector('tbody');
    const feedbackRating = document.getElementById('insertRating').value;

    let query = `/join-feedback-rating/${feedbackRating}`;

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

let columns = new Set();
let table = "";

function clearQuery() {
    const currentColumns = document.getElementById('currentColumns');
    const currentTable = document.getElementById('currentTable');

    columns = new Set();
    table = "";
    currentColumns.textContent = `Column cleared`;
    currentTable.textContent = `Table cleared`;
}

function addColumn() {
    const currentColumns = document.getElementById('currentColumns');
    const newColumn = document.getElementById('columnInput');
    if (newColumn.value.length > 0) {
        try {
            columns.add(newColumn.value.trim());
            currentColumns.textContent = `Column added: ${Array.from(columns).join(', ')}`;
        } catch (err) {
            console.log(err);
            currentColumns.textContent = "Error adding column";
        }
    } else {
        currentColumns.textContent = `Column added: ${Array.from(columns).join(', ')}`;
    }
}

function setTable() {
    const currentTable = document.getElementById('currentTable');
    const newTable = document.getElementById('tableInput');
    try {
        table = newTable.value.trim();
        currentTable.textContent = `Table set: ${table}`;
    } catch (err) {
        console.log(err);
        currentTable.textContent = "Error adding column";
    }
}

async function submitQuery() {
    const messageElement = document.getElementById('currentTable');

    fetch(`/query-dataset/${table}/${Array.from(columns).join(', ')}`, {
        method: 'GET'
    }).then(response => response.json()
    ).then(async (data) => {
        let worked = await renderTable("Queried Results", data)
        if (worked) {
            messageElement.textContent = "Query Complete!";
        } else {
            messageElement.textContent = "Query Failed!";
        }
    }).catch((err) => {
        console.log(err);
        messageElement.textContent = "Error Querying!";
    })
}


// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    fetchAndDisplayAllColumns("Current Users",TABLE.USERINFO.name)

    document.getElementById("insertUser").addEventListener("submit", insertUser);
    document.getElementById("joinFeedbackRating").addEventListener("submit", joinFeedbackTable);
    document.getElementById("clearQuery").addEventListener("click", clearQuery);
    document.getElementById("addColumn").addEventListener("click", addColumn);
    document.getElementById("setTable").addEventListener("click", setTable);
    document.getElementById("submitQuery").addEventListener("click", submitQuery);
};