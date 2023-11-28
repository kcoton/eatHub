/**
 * Contains functionalities for contributor dashboard
 */


const userId = 1; // contributor will only show values for specific userId


// To standardize tableId and tableName
const TABLE = {
    MEAL: { id: 'mealTable', name: 'meal' },
    FEEDBACK: { id: 'feedbackTable', name: 'feedback' },
    RECIPE: { id: 'recipeTable', name: 'recipe' }
}


// Fetches data from all tables and displays it.
async function fetchAndDisplayAllTables() {
    fetchAndDisplayTable(TABLE.MEAL.id, TABLE.MEAL.name);
    fetchAndDisplayTable(TABLE.FEEDBACK.id, TABLE.FEEDBACK.name, userId);
    fetchAndDisplayTable(TABLE.RECIPE.id, TABLE.RECIPE.name);
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
    
    // Updates select options
    if (tableId == TABLE.FEEDBACK.id) {
        fetchAndDisplayFeedbackOptions(tableContent);
    } else if (tableId == TABLE.RECIPE.id) {
        fetchAndDisplayRecipeCategoryOptions(tableContent);
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

    if (!isSanitized(mealName) || !isSanitized(mealCategory)) {
        messageElement.textContent = "Please remove *, ;, or ? from the input";
        return;
    } else {
        console.log("mealName & mealCategory passed the sanitization test")
    }

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
        fetchAndDisplayTable(TABLE.RECIPE.id, TABLE.RECIPE.name);
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


// Fetches feedbackId from Feedback and displays as select options.
async function fetchAndDisplayRecipeCategoryOptions(recipeContent) {
    const selectElement = document.getElementById('selectRecipeCategory');

    // always clear old, already fetched data before new fetching process
    if (selectElement) {
        selectElement.innerHTML = '';
    }

    const addedOptions = new Set();

    recipeContent.forEach(recipe => {
        const category = recipe[2];

        // Check if the option is already added
        if (!addedOptions.has(category)) {
            const option = new Option(category, category);
            selectElement.options.add(option);
            addedOptions.add(category);
        }
    });
}


// Updates existing feedback in the Feedback table.
async function updateFeedback(event) {
    event.preventDefault();

    const feedbackId = document.getElementById('selectFeedbackId').value;
    const versionId = document.getElementById('updateVersionId').value;
    const feedbackComment = document.getElementById('updateComment').value;
    const feedbackRating = document.getElementById('updateRating').value;

    if (!isSanitized(feedbackComment)) {
        messageElement.textContent = "Please remove *, ;, or ? from the comment";
        return;
    } else {
        console.log("feedbackComment passed the sanitization test")
    }

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


// Selects existing recipes (optional param: recipeCategory) in the Recipe table and displays it.
async function selectRecipe(event) {
    event.preventDefault();

    const selectElement = document.getElementById('selectRecipeCategory');
    const recipeCategory = 
        Array.from(selectElement)
            .filter(option => option.selected)
            .map(option => option.value);

    const queryParams = new URLSearchParams({ recipeCategory: recipeCategory.join(',') }).toString();
   // example array endpoint: /get-recipe?recipeCategory=Italian,Asian
    const response = await fetch('/get-recipe?' + queryParams, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    });

    const responseData = await response.json();
    const tableContent = responseData.data;
    const messageElement = document.getElementById('selectRecipeResult');

    const tableElement = document.getElementById(TABLE.RECIPE.id);
    const tableBody = tableElement.querySelector('tbody');
    
    // Always clear old, already fetched data before new fetching process.
    if (tableBody) {
        tableBody.innerHTML = '';
    }

    if (responseData.success) {
        messageElement.textContent = "Recipe category select successfully!";
        tableContent.forEach(tuple => {
            const row = tableBody.insertRow();
            tuple.forEach((field, index) => {
                const cell = row.insertCell(index);
                cell.textContent = field;
            });
        });
    } else {
        messageElement.textContent = "Error selecting recipe category!";
    }
}

async function nestedQueryFeedback() {
    const messageElement = document.getElementById('nestedQueryFeedbackResult');
    let age = document.getElementById('ageInput').value;

    if (!isSanitized(age)) {
        messageElement.textContent = "Please remove *, ;, or ? from the field";
        return;
    }

    fetch(`/nested-query-dataset/${age}`, {
        method: 'GET'
    }).then(response => response.json()
    ).then(async (data) => {
        let worked = await renderTable(`User Age < ${age} years old`, data);
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
    fetchAndDisplayAllTables();

    document.getElementById("welcome").textContent = `Welcome, Contributor! (UserId = ${userId})`;
    document.getElementById("insertMeal").addEventListener("submit", insertMeal);
    document.getElementById("deleteRecipe").addEventListener("submit", deleteRecipe);
    document.getElementById("updateFeedback").addEventListener("submit", updateFeedback);
    document.getElementById("selectRecipe").addEventListener("submit", selectRecipe);
    document.getElementById("nestedQueryFeedback").addEventListener("click", nestedQueryFeedback);
};