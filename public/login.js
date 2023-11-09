/**
 * Login to selected user, navigates to dashboard
 */

// fetch and display user login options from UserType
async function fetchAndDisplayUserType() {
    const selectElement = document.getElementById('userType');

    const response = await fetch('/get-table/usertype', {
        method: 'GET'
    });
    
    const responseData = await response.json();
    const userTypeContent = responseData.data;

    // always clear old, already fetched data before new fetching process
    if (selectElement) {
        selectElement.innerHTML = '';
    }

    userTypeContent.forEach(type => {
        const option = new Option(type[1], type[1]);
        selectElement.options.add(option);
    });
}

// login to selected user, navigates to dashboard
async function login() {
    const userType = document.getElementById('userType').value;
    window.location.href = `/${userType}-dashboard.html`;
}


fetchAndDisplayUserType();