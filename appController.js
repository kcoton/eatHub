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

// get table data with table name param using GET request
router.get('/get-table/:tableName', async (req, res) => {
    const tableName = req.params.tableName.toUpperCase();
    const tableContent = await appService.getTable(tableName);
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

module.exports = router;