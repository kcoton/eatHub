/**
 * Contains functionalities for admin dashboard
 */

// To standardize tableId and tableName
const TABLE = {
    USERINFO: { id: 'userTable', name: 'userinfo' },
    FEEDBACK: { id: 'feedbackTable', name: 'feedback' }
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

// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    fetchAndDisplayAllColumns("Current Users",TABLE.USERINFO.name)

    document.getElementById("insertUser").addEventListener("submit", insertUser);
    document.getElementById("submitQuery").addEventListener("click", submitQuery);
    document.getElementById("getAllTables").addEventListener("click", getAllTables);
    document.getElementById("getAllColumns").addEventListener("click", getAllColumns);
};