const express = require('express');
const appService = require('./appService');

const router = express.Router();

// ----------------------------------------------------------
// API endpoints
// Modify or extend these routes based on your project's needs.
router.get('/check-db-connection', async (req, res) => {
    const isConnect = await appService.testOracleConnection();
    if (isConnect) {
        res.send('connected');
    } else {
        res.send('unable to connect');
    }
});


/** INITIATE SQL */

// drop & create schema tables using POST request
router.post("/create-tables", async (req, res) => {
    const response = await appService.createTables();
    if (response) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

// insert sample data using POST request
router.post("/insert-samples", async (req, res) => {
    const response = await appService.insertSamples();
    if (response) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});


/** CRUD ENDPOINTS */

// get table data with tableName param using GET request
router.get('/get-table/:tableName', async (req, res) => {
    const tableName = req.params.tableName.toUpperCase();
    const tableContent = await appService.getTable(tableName);
    res.json({ data: tableContent });
});

// get table data with tableName and userId param using GET request
router.get('/get-table/:tableName/:userId', async (req, res) => {
    const tableName = req.params.tableName.toUpperCase();
    const userId = req.params.userId;
    const tableContent = await appService.getTable(tableName, userId);
    res.json({ data: tableContent });
});

// insert new user into UserInfo using POST request
router.post('/insert-user', async (req, res) => {
    const { userId, userType, email, name, birthday, weight, height } = req.body;
    const insertResult = await appService.insertUser(userId, userType, email, name, birthday, weight, height);
    if (insertResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

// insert new meal into Meal using POST request
router.post('/insert-meal', async (req, res) => {
    const { mealId, mealPlanId, mealName, mealCategory, mealDay } = req.body;
    const insertResult = await appService.insertMeal(mealId, mealPlanId, mealName, mealCategory, mealDay);
    if (insertResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

// delete existing recipe in Recipe using DELETE request
router.delete('/delete-recipe', async (req, res) => {
    const { recipeId } = req.body;
    const deleteResult = await appService.deleteRecipe(recipeId);
    if (deleteResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

// update existing feedback in Feedback using UPDATE request
router.put('/update-feedback', async (req, res) => {
    const { versionId, recipeId, feedbackComment, feedbackRating, feedbackDate, feedbackId } = req.body;
    const updateResult = await appService.updateFeedback(versionId, recipeId, feedbackComment, feedbackRating, feedbackDate, feedbackId);
    if (updateResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

// get existing recipe with recipeCategory param in Recipe using GET request
router.get('/get-recipe', async (req, res) => {
    const recipeCategories = req.query.recipeCategory;
    let recipeCategory = null; 
    if (recipeCategories) {
        recipeCategory = recipeCategories.split(',');
    }
    const tableContent = await appService.getRecipe(recipeCategory);
    if (tableContent) {
        res.json({ success: true, data: tableContent });
    } else {
        res.status(500).json({ success: false });
    }
});

// get versions with feedbackRating >= X param in joined Version/Recipe/Feedback using GET request
router.get('/join-feedback-rating/:feedbackRating', async (req, res) => {
    const feedbackRating = req.params.feedbackRating;
    const tableContent = await appService.joinFeedbackRating(feedbackRating);
    if (tableContent) {
        res.json({ success: true, data: tableContent });
    } else {
        res.status(500).json({ success: false });
    }
});

// count contributions by userId in Feedback using GET request
router.get('/count-feedback', async (req, res) => {
    const tableContent = await appService.countFeedbackByUser();
    if (tableContent) {
        res.json({ success: true, data: tableContent });
    } else {
        res.status(500).json({ success: false });
    }
});

// get table data with tableName and fields param using GET request
router.get('/query-dataset/:tableName/:fields', async (req, res) => {
    const tableName = req.params.tableName.toUpperCase();
    const fields = req.params.fields;
    const tableContent = await appService.queryTable(tableName, fields);
    res.json({ data: tableContent });

});

router.get('/query-dataset/:tableName/:fields/:where', async (req, res) => {
    const tableName = req.params.tableName.toUpperCase();
    const fields = req.params.fields;
    const tableContent = await appService.queryTableWhere(tableName, fields, req.params.where);
    res.json({ data: tableContent });

});

// get table data with tableName and fields param using GET request
router.get('/nested-query-dataset/:age', async (req, res) => {
    const tableContent = await appService.nestedQueryFeedback(req.params.age);
    res.json({ data: tableContent });
});

// get table data aggregation with having Number of Versions per recipe
router.get('/aggregation-with-having-dataset/:count', async (req, res) => {
    const tableContent = await appService.aggregationHaving(req.params.count);
    if (tableContent) {
        res.json({ success: true, data: tableContent });
    } else {
        res.status(500).json({ success: false });
    }
});

module.exports = router;