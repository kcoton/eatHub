/**
 * Contains functionalities for contributor dashboard
 */


const userId = 1; // contributor will only show values for specific userId


// To standardize tableId and tableName
const TABLE = {
    MEAL: { id: 'mealTable', name: 'meal' },
    FEEDBACK: { id: 'feedbackTable', name: 'feedback' }
}


// Fetches data from all tables and displays it.
async function fetchAndDisplayAllTables() {
    fetchAndDisplayTable(TABLE.MEAL.id, TABLE.MEAL.name);
    fetchAndDisplayTable(TABLE.FEEDBACK.id, TABLE.FEEDBACK.name, userId);
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
    
    // Updates select feedbackId options
    if (tableId == TABLE.FEEDBACK.id) {
        fetchAndDisplayFeedbackOptions(tableContent);
    }

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
        fetchAndDisplayTable(TABLE.MEAL.id, TABLE.MEAL.name);
    } else {
        messageElement.textContent = "Error inserting meal!";
    }
}


// Deletes existing recipe in the Recipe table.
async function deleteRecipe(event) {
    event.preventDefault();

    const recipeId = document.getElementById('deleteRecipeId').value;

    const response = await fetch('/delete-recipe', {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            recipeId: recipeId
        })
    });

    const responseData = await response.json();
    const messageElement = document.getElementById('deleteRecipeResult');

    if (responseData.success) {
        messageElement.textContent = "Recipe deleted successfully!";
    } else {
        messageElement.textContent = "Error deleting recipe!";
    }
}


// Fetches feedbackId from Feedback and displays as select options.
async function fetchAndDisplayFeedbackOptions(feedbackContent) {
    const selectElement = document.getElementById('selectFeedbackId');

    // always clear old, already fetched data before new fetching process
    if (selectElement) {
        selectElement.innerHTML = '';
    }

    feedbackContent.forEach(feedback => {
        const option = new Option(feedback[0], feedback[0]);
        selectElement.options.add(option);
    });
}


// Updates existing feedback in the Feedback table.
async function updateFeedback(event) {
    event.preventDefault();

    const feedbackId = document.getElementById('selectFeedbackId').value;
    const versionId = document.getElementById('updateVersionId').value;
    const feedbackComment = document.getElementById('updateComment').value;
    const feedbackRating = document.getElementById('updateRating').value;

    const response = await fetch('/update-feedback', {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            feedbackId: feedbackId,
            versionId: versionId,
            feedbackComment: feedbackComment,
            feedbackRating: feedbackRating
        })
    });

    const responseData = await response.json();
    const messageElement = document.getElementById('updateFeedbackResult');

    if (responseData.success) {
        messageElement.textContent = "Feedback updated successfully!";
        fetchAndDisplayTable(TABLE.FEEDBACK.id, TABLE.FEEDBACK.name, userId);
    } else {
        messageElement.textContent = "Error updating feedback!";
    }
}


// ---------------------------------------------------------------
// Initializes the webpage functionalities.
// Add or remove event listeners based on the desired functionalities.
window.onload = function() {
    fetchAndDisplayAllTables();

    document.getElementById("welcome").textContent = `Welcome, Contributor! (UserId = ${userId})`;
    document.getElementById("insertMeal").addEventListener("submit", insertMeal);
    document.getElementById("deleteRecipe").addEventListener("submit", deleteRecipe);
    document.getElementById("updateFeedback").addEventListener("submit", updateFeedback);
};