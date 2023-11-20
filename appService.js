const oracledb = require('oracledb');
const fs = require('fs');
const loadEnvFile = require('./utils/envUtil');

const envVariables = loadEnvFile('./.env');

// Database configuration setup. Ensure your .env file has the required database credentials.
const dbConfig = {
    user: envVariables.ORACLE_USER,
    password: envVariables.ORACLE_PASS,
    connectString: `${envVariables.ORACLE_HOST}:${envVariables.ORACLE_PORT}/${envVariables.ORACLE_DBNAME}`
};


// ----------------------------------------------------------
// Wrapper to manage OracleDB actions, simplifying connection handling.
async function withOracleDB(action) {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        return await action(connection);
    } catch (err) {
        console.error(err);
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
}


// ----------------------------------------------------------
// Core functions for database operations
// Modify these functions, especially the SQL queries, based on your project's requirements and design.
async function testOracleConnection() {
    return await withOracleDB(async (connection) => {
        return true;
    }).catch(() => {
        return false;
    });
}


/** INITIATE SQL */

// Used to Create Table from schema.sql
async function createTables(){
    try {    
        const sql = fs.readFileSync('db/schema.sql','utf-8');
        const statements = sql.split(';');
        
        // let i = 0;
        for (const statement of statements) {
            if (statement.trim() === '') {
                continue;
            }
            
            let status = await withOracleDB(async (connection) => {
                try {
                    let result = await connection.execute(statement.trim());
                    let commit = await connection.commit();
                } catch(err) {
                    console.log('err @ appService.createTable: ' + err);
                }   
            });
        }
        
        console.log("creating table finished");
        return "creating table finished";

    } catch (e) {
        console.log("File not read correctly. Tables not created correctly.")
    }
}

// Used to INSERT sample table
async function insertSamples(){
    try {    
        const sql = fs.readFileSync('db/insert_samples.sql','utf-8');
        const statements = sql.split(';');
        
        // let i = 0;
        for (const statement of statements) {
            if (statement.trim() === '') {
                continue;
            }
            
            let status = await withOracleDB(async (connection) => {
                try {
                    let result = await connection.execute(statement.trim());
                    let commit = await connection.commit();
                } catch(err) {
                    console.log('err @ appService.insertSamples: ' + err);
                }   
            });
        }
        
        console.log("loading data finished");
        return "loading data finished";

    } catch (e) {
        console.log("File not read correctly. Tables not created correctly.")
    }
}


/** GET, POST, UPDATE, DELETE TO DB */


// GET: returns all rows in a table OR all rows containing a userId
async function getTable(tableName, userId = null) {
    return await withOracleDB(async (connection) => {
        let query = `SELECT * FROM ${tableName}`;
        if (!!userId) {
            query = query.concat(` WHERE userId = ${userId}`);
        }
        const result = await connection.execute(query);
        return result.rows;
    }).catch((e) => {
        console.log("Error at getTable", e);
        return [];
    });
}

// POST: inserts a user into UserInfo
async function insertUser(userId, userType, email, name, birthday, weight, height) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `INSERT INTO USERINFO (userId, userType, email, name, birthday, weight, height) 
            VALUES (:userId, :userType, :email, :name, TO_DATE(:birthday, 'YYYY-MM-DD'), :weight, :height)`,
            [userId, userType, email, name, birthday, weight, height],
            { autoCommit: true }
        );
        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

// POST: inserts a meal into Meal
async function insertMeal(mealId, mealPlanId, mealName, mealCategory, mealDay) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `INSERT INTO MEAL (mealId, mealPlanId, mealName, mealCategory, mealDay) 
            VALUES (:mealId, :mealPlanId, :mealName, :mealCategory, TO_DATE(:mealDay, 'YYYY-MM-DD'))`,
            [mealId, mealPlanId, mealName, mealCategory, mealDay],
            { autoCommit: true }
        );
        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

// DELETE: deletes a recipe in Recipe
async function deleteRecipe(recipeId) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `DELETE FROM RECIPE WHERE recipeId = :recipeId`,
            [recipeId],
            { autoCommit: true }
        );
        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

// UPDATE: updates feedback in Feedback
async function updateFeedback(versionId, feedbackComment, feedbackRating, feedbackId) {
    return await withOracleDB(async (connection) => {
        const query = 
            `UPDATE FEEDBACK 
            SET versionId = :versionId, feedbackComment = :feedbackComment, feedbackRating = :feedbackRating 
            WHERE feedbackId = :feedbackId`;
        const result = await connection.execute(
            query,
            [versionId, feedbackComment, feedbackRating, feedbackId],
            { autoCommit: true }
        );
        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}


module.exports = {
    testOracleConnection,
    createTables,
    insertSamples,
    getTable,
    insertUser,
    insertMeal,
    deleteRecipe,
    updateFeedback
};