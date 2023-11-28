/**
 * Contains functionalities for admin dashboard
 */

// To standardize tableId and tableName
const TABLE = {
    USERINFO: { id: 'userTable', name: 'userinfo' },
    FEEDBACK: { id: 'feedbackTable', name: 'feedback' },
    HAVING_TABLE: {id: 'havingTable' },
    JOIN_FEEDBACK: { id: 'joinFeedbackTable' },
    COUNT_FEEDBACK: { id: 'countFeedbackTable' }
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

    const messageElement = document.getElementById('insertUserResult');

    if (!isSanitized(email) || !isSanitized(name)) {
        messageElement.textContent = "Please remove *, ;, or ? from the input";
        return;
    } else {
        console.log("email passed the sanitization test")
    }

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

    if (responseData.success) {
        messageElement.textContent = "User inserted successfully!";
        fetchAndDisplayAllColumns("Current Users",TABLE.USERINFO.name)
    } else {
        messageElement.textContent = "Error inserting user!";
    }
}

// Joins version/feedback/recipe to show results with feedbackRating >= X
async function joinFeedbackTable(event) {
    event.preventDefault();

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

// Counts feedback contribution per userId
async function countFeedback(event) {
    event.preventDefault();

    let query = `/count-feedback`;
    const tableElement = document.getElementById(TABLE.COUNT_FEEDBACK.id);
    const tableBody = tableElement.querySelector('tbody');
    

    const response = await fetch(query, { method: 'GET' });
    const responseData = await response.json();
    const tableContent = responseData.data;

    const messageElement = document.getElementById('countFeedbackResult');

    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    if (responseData.success) {
        messageElement.textContent = "Count feedback by user successful!";
        tableContent.forEach(tuple => {
            const row = tableBody.insertRow();
            tuple.forEach((field, index) => {
                const cell = row.insertCell(index);
                cell.textContent = field;
            });
        });
    } else {
        messageElement.textContent = "Error with count feedback by user!";
    }
}

// Joins version/feedback/recipe to show results with feedbackRating >= X
async function joinFeedbackTable(event) {
    event.preventDefault();

    const tableElement = document.getElementById(TABLE.JOIN_FEEDBACK.id);
    const tableBody = tableElement.querySelector('tbody');
    const feedbackRating = document.getElementById('insertRating').value;
    const messageElement = document.getElementById('joinFeedbackRatingResult');

    let query = `/join-feedback-rating/${feedbackRating}`;

    const response = await fetch(query, { method: 'GET' });
    const responseData = await response.json();
    const tableContent = responseData.data;

    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    if (responseData.success) {
        messageElement.textContent = "Join for rating successful!";
        tableContent.forEach(tuple => {
            const row = tableBody.insertRow();
            tuple.forEach((field, index) => {
                const cell = row.insertCell(index);
                cell.textContent = field;
            });
        });
    } else {
        messageElement.textContent = "Error with join for rating!";
    }
}

// Counts feedback contribution per userId
async function countFeedback(event) {
    event.preventDefault();

    let query = `/count-feedback`;
    const tableElement = document.getElementById(TABLE.COUNT_FEEDBACK.id);
    const tableBody = tableElement.querySelector('tbody');
    

    const response = await fetch(query, { method: 'GET' });
    const responseData = await response.json();
    const tableContent = responseData.data;

    const messageElement = document.getElementById('countFeedbackResult');

    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    if (responseData.success) {
        messageElement.textContent = "Count feedback by user successful!";
        tableContent.forEach(tuple => {
            const row = tableBody.insertRow();
            tuple.forEach((field, index) => {
                const cell = row.insertCell(index);
                cell.textContent = field;
            });
        });
    } else {
        messageElement.textContent = "Error with count feedback by user!";
    }
}

// PROJECTION
async function getAllTables() {
    const messageElement = document.getElementById('currentTable');
    const dropdownElement = document.getElementById('allTables');

    fetch(`/query-dataset/user_tables/table_name`, {
        method: 'GET'
    }).then(response => response.json()
    ).then(async (data) => {
        dropdownElement.innerHTML = '';
        let dropdown = document.createElement('select');
        dropdown.id = "dropdownTableValue";
        dropdown.addEventListener('input', getAllColumns);

        const defaultOption = document.createElement('option');
        defaultOption.value = "";
        defaultOption.label = "Select Table from Below";
        defaultOption.disabled = true;
        defaultOption.selected = true;
        dropdown.appendChild(defaultOption);

        data.data.rows.forEach(item => {
            const optionElement = document.createElement('option');
            optionElement.value = item;
            optionElement.label = item;
            dropdown.appendChild(optionElement);
        })
        dropdownElement.appendChild(dropdown);
    }).catch((err) => {
        console.log(err);
        messageElement.textContent = "Error Querying!";
    })
}

async function getAllColumns() {
    const messageElement = document.getElementById('currentTable');
    const dropdownElement = document.getElementById('allColumns');

    let tableName = document.getElementById('dropdownTableValue');
    if (!tableName) {
        messageElement.textContent = "Error with table name!";
        return;
    }

    console.log(`/query-dataset/user_tab_columns/column_name/table_name='${tableName.value.trim()}'`);

    fetch(`/query-dataset/user_tab_columns/column_name/table_name='${tableName.value.trim()}'`, {
        method: 'GET'
    }).then(response => response.json()
    ).then(async (data) => {
        dropdownElement.innerHTML = '';
        
        let dropdown = document.createElement('select');
        dropdown.id = "dropdownColumnsValues";
        dropdown.multiple = true;

        const defaultOption = document.createElement('option');
        defaultOption.value = "";
        defaultOption.label = "Select Columns from Below";
        defaultOption.disabled = true;
        // defaultOption.selected = true;
        dropdown.appendChild(defaultOption);

        data.data.rows.forEach(item => {
            const optionElement = document.createElement('option')
            optionElement.value = item
            optionElement.label = item
            dropdown.appendChild(optionElement);
        })

        dropdownElement.appendChild(dropdown);
    }).catch((err) => {
        console.log(err);
        messageElement.textContent = "Error Querying!";
    })
}

async function submitQuery() {
    const messageElement = document.getElementById('currentTable');

    let tableName = document.getElementById('dropdownTableValue');
    let tableNameString = tableName.value.trim();
    let columnNames = document.getElementById('dropdownColumnsValues');
    let columnNamesString = Array.from(columnNames.selectedOptions).map(option => option.value).join(', ')
    
    console.log(`/query-dataset/${tableNameString}/${columnNamesString}`);

    fetch(`/query-dataset/${tableNameString}/${columnNamesString}`, {
        method: 'GET'
    }).then(response => response.json()
    ).then(async (data) => {
        let worked = await renderTable("Queried Results", data)
        if (worked) {
            messageElement.textContent = "Query Complete. Table updated!";
        } else {
            messageElement.textContent = "Query Failed!";
        }
    }).catch((err) => {
        console.log(err);
        messageElement.textContent = "Error Querying!";
    })
}

// Returns a table with the number of counts of version for a Recipe
async function aggregationHaving(event) {
    event.preventDefault();
    
    const tableElement = document.getElementById(TABLE.HAVING_TABLE.id);
    const tableBody = tableElement.querySelector('tbody');
    
    const messageElement = document.getElementById('aggregationHavingResult');
    let count = document.getElementById('countInput').value;

    const response = await fetch(`/aggregation-with-having-dataset/${count}`, {
        method: 'GET'
    });

    const responseData = await response.json();
    const tableContent = responseData.data;

    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    if (responseData.success) {
        messageElement.textContent = 'Count number of versions per recipe successful!';
        tableContent.forEach(tuple => {
            const row = tableBody.insertRow();
            tuple.forEach((field, index) => {
                const cell = row.insertCell(index);
                cell.textContent = field;
            });
        });  
    } else {
        messageElement.textContent = "Error with count number of versions per recipe!";
    }
}

// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    fetchAndDisplayAllColumns("Current Users",TABLE.USERINFO.name)

    document.getElementById("insertUser").addEventListener("submit", insertUser);
    document.getElementById("joinFeedbackRating").addEventListener("submit", joinFeedbackTable);
    document.getElementById("submitQuery").addEventListener("click", submitQuery);
    document.getElementById("getAllTables").addEventListener("click", getAllTables);
    // document.getElementById("getAllColumns").addEventListener("click", getAllColumns);
    document.getElementById("countVersion").addEventListener("submit", aggregationHaving);
    document.getElementById("countFeedback").addEventListener("submit", countFeedback);
};