/*
 * These functions below are for various webpage functionalities. 
 * Each function serves to process data on the frontend:
 *      - Before sending requests to the backend.
 *      - After receiving responses from the backend.
 * 
 * To tailor them to your specific needs,
 * adjust or expand these functions to match both your 
 *   backend endpoints 
 * and 
 *   HTML structure.
 * 
 */

/**
 * Shared functionalities between pages should be put here
 */
// Fetches data from the UserInfo table and displays it.
async function fetchAndDisplayAllColumns(tableTitle, tableName) {
    fetch(`/query-dataset/${tableName}/*`, {
        method: 'GET'
    }).then(response => response.json())
    .then((data) => {
        renderTable(tableTitle, data);
    }).catch((err) => {
        console.log(err);
    })
}

// Fetches data from the UserInfo table and displays it.
async function renderTable(header, dataJson) {
    try {
        const resultContainer = document.getElementById('resultContainer');
        const tableContainer = document.getElementById('tableContainer');
        // reset
        resultContainer.innerHTML = '';
        tableContainer.innerHTML = '';

        // header text
        const headerText = document.createElement('h2');
        headerText.textContent = header;

        // create table
        const table = jsonToHtmlTable(dataJson);

        // append
        resultContainer.appendChild(headerText);
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


// This function checks the database connection and updates its status on the frontend.
async function checkDbConnection() {
    const statusElem = document.getElementById('dbStatus');
    const loadingGifElem = document.getElementById('loadingGif');

    const response = await fetch('/check-db-connection', {
        method: "GET"
    });

    // Hide the loading GIF once the response is received.
    loadingGifElem.style.display = 'none';
    // Display the statusElem's text in the placeholder.
    statusElem.style.display = 'inline';

    response.text()
    .then((text) => {
        statusElem.textContent = text;
    })
    .catch((error) => {
        statusElem.textContent = 'connection timed out';  // Adjust error handling if required.
    });
}

function isSanitized(input) {
    if (input.includes(";") || input.includes("*") || input.includes("?")) {
        return false;
    } 
    return true;
}

// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    checkDbConnection();
};


