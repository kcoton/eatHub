/**
 * Contains functionalities for admin dashboard
 */

// Fetches data from the UserInfo table and displays it.
async function fetchAndDisplayUsers() {
    fetch('/query-dataset/userinfo/*', {
        method: 'GET'
    }).then(response => response.json())
    .then((data) => {
        renderTable("View All users", data);
    }).catch((err) => {
        console.log(err);
    })
}


// Fetches data from the UserInfo table and displays it.
async function renderTable(header, dataJson) {
    try {
        const tableContainer = document.getElementById('tableContainer');
        // reset
        tableContainer.innerHTML = '';

        // header text
        const headerText = document.createElement('h2');
        headerText.textContent = header;

        // create table
        const table = jsonToHtmlTable(dataJson);

        // append
        tableContainer.appendChild(headerText);
        tableContainer.appendChild(table);
        return true;
    } catch (err) {
        return false;
    }
}

function jsonToHtmlTable(dataJson) {
	const table = document.createElement('table');
	table.classList.add('table');
	const header = table.createTHead();
	const body = table.createTBody();

	// Create table header row
    const headerRow = header.insertRow();
	console.log(dataJson)
    dataJson.data.metaData.forEach(elem => {
		const th = document.createElement('th');
		th.textContent = elem.name;
		headerRow.appendChild(th);
	});

	// Populate table body
	dataJson.data.rows.forEach(item => {
		const row = body.insertRow();
		Object.values(item).forEach(value => {
			const cell = row.insertCell();
			cell.textContent = value.length > 50 ? value.substring(0, 50) + '...' : value;
		});
	});

	return table;
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
    }).then(response => response.json())
    .then(async (data) => {
        let worked = await renderTable("View All users", data)
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
    document.getElementById("insertUser").addEventListener("submit", insertUser);
    document.getElementById("clearQuery").addEventListener("click", clearQuery);
    document.getElementById("addColumn").addEventListener("click", addColumn);
    document.getElementById("setTable").addEventListener("click", setTable);
    document.getElementById("submitQuery").addEventListener("click", submitQuery);
};