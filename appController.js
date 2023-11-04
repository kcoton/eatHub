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

router.get('/demotable', async (req, res) => {
    const tableContent = await appService.fetchDemotableFromDb();
    res.json({data: tableContent});
});

router.post("/initiate-demotable", async (req, res) => {
    const initiateResult = await appService.initiateDemotable();
    if (initiateResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.post("/insert-demotable", async (req, res) => {
    const { id, name } = req.body;
    const insertResult = await appService.insertDemotable(id, name);
    if (insertResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.post("/update-name-demotable", async (req, res) => {
    const { oldName, newName } = req.body;
    const updateResult = await appService.updateNameDemotable(oldName, newName);
    if (updateResult) {
        res.json({ success: true });
    } else {
        res.status(500).json({ success: false });
    }
});

router.get('/count-demotable', async (req, res) => {
    const tableCount = await appService.countDemotable();
    if (tableCount >= 0) {
        res.json({ 
            success: true,  
            count: tableCount
        });
    } else {
        res.status(500).json({ 
            success: false, 
            count: tableCount
        });
    }
});

// mock get request to CREATE table
router.get('/createtables', async (req, res) => {
    try {
        const tableContent = await appService.createTables();
        res.json({
            returned: tableContent
        })
    }catch(e) {
        console.log("create threw an error");
    }
});


// mock get request to INSERT sample tables
router.get('/insertsamples', async (req, res) => {
    try {
        const tableContent = await appService.insertSamples();
        res.json({
            returned: tableContent
        })
    }catch(e) {
        console.log("insertsamples threw an error");
    }
});

// convert viewtable url param
router.param('tableName', function(req, res, next, tableName) {
    const modified = tableName.toUpperCase();
  
    req.tableName = modified;
    next();
});

// mock get request to create table
router.get('/viewtable/:tableName', async (req, res) => {
    try {
        const tableName = req.tableName;
        console.log(tableName);
        const tableContent = await appService.viewTable(tableName);
        res.json({
            data: tableContent
        });
    }catch(e) {
        console.log("createtable threw an error");
    }
});

module.exports = router;