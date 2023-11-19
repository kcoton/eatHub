/**
 * Contains functionalities for contributor dashboard
 */


const userId = 1; // contributor will only show values for specific userId


// Fetches data from all tables and displays it.
async function fetchAndDisplayTables() {
    fetchAndDisplayMealPlans();
    fetchAndDisplayMeals();
}


// Fetches data from the MealPlan table and displays it.
async function fetchAndDisplayMealPlans() {
    const tableElement = document.getElementById('mealPlanTable');
    const tableBody = tableElement.querySelector('tbody');

    const response = await fetch(`/get-table/mealplan/${userId}`, {
        method: 'GET'
    });

    const responseData = await response.json();
    const mealPlanTableContent = responseData.data;

    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    mealPlanTableContent.forEach(user => {
        const row = tableBody.insertRow();
        user.forEach((field, index) => {
            const cell = row.insertCell(index);
            cell.textContent = field;
        });
    });
}


// Fetches data from the Meal table and displays it.
async function fetchAndDisplayMeals() {
    const tableElement = document.getElementById('mealTable');
    const tableBody = tableElement.querySelector('tbody');

    const response = await fetch('/get-table/meal', {
        method: 'GET'
    });

    const responseData = await response.json();
    const mealTableContent = responseData.data;

    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    mealTableContent.forEach(user => {
        const row = tableBody.insertRow();
        user.forEach((field, index) => {
            const cell = row.insertCell(index);
            cell.textContent = field;
        });
    });
}


// Inserts new meal plan into the MealPlan table.
async function insertMeal(event) {
    event.preventDefault();

    const mealId = document.getElementById('insertMealId').value;
    const mealPlanId = document.getElementById('insertMealPlanId').value;
    const mealName = document.getElementById('insertMealName').value;
    const mealCategory = document.getElementById('insertMealCategory').value;
    const mealDay = document.getElementById('insertMealDay').value;

    const response = await fetch('/insert-meal', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            mealId: mealId,
            mealPlanId: mealPlanId,
            mealName: mealName,
            mealCategory: mealCategory,
            mealDay: mealDay
        })
    });

    const responseData = await response.json();
    const messageElement = document.getElementById('insertMealResult');

    if (responseData.success) {
        messageElement.textContent = "Meal inserted successfully!";
        fetchAndDisplayMeals();
    } else {
        messageElement.textContent = "Error inserting meal!";
    }
}


// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    fetchAndDisplayTables();

    document.getElementById("welcome").textContent = `Welcome, Contributor! (UserId = ${userId})`;
    document.getElementById("insertMeal").addEventListener("submit", insertMeal);
};