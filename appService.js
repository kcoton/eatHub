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


/** GET, POST, PUT, UPDATE, DELETE TO DB */


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

// GET: returns all rows in Recipe (optional param: recipeCategory)
async function getRecipe(recipeCategory) {
    return await withOracleDB(async (connection) => {
        let query = `SELECT * FROM RECIPE`;
        if (!!recipeCategory) {
            recipeCategory.forEach((category, i) => {
                if (i == 0) {
                    query = query.concat(` WHERE recipeCategory = '${category}'`);
                } else query = query.concat(` OR recipeCategory = '${category}'`);
                
            })
        }
        const result = await connection.execute(query);
        return result.rows;
    }).catch((e) => {
        console.log("Error at getRecipe", e);
        return [];
    });
}

// GET: returns all rows in a table OR all rows containing a userId
async function getTableWithHeader(tableName, userId = null) {
    return await withOracleDB(async (connection) => {
        let query = `SELECT * FROM ${tableName}`;
        const result = await connection.execute(query);
        return result;
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
async function updateFeedback(versionId, recipeId, feedbackComment, feedbackRating, feedbackDate, feedbackId) {
    return await withOracleDB(async (connection) => {
        const query = 
            `UPDATE FEEDBACK 
            SET versionId = :versionId, recipeId = :recipeId, feedbackComment = :feedbackComment, feedbackRating = :feedbackRating, feedbackDate = TO_DATE(:feedbackDate, 'YYYY-MM-DD') 
            WHERE feedbackId = :feedbackId`;
        const result = await connection.execute(
            query,
            [versionId, recipeId, feedbackComment, feedbackRating, feedbackDate, feedbackId],
            { autoCommit: true }
        );
        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

// JOIN: joins version, recipe, feedback, and queries feedbackRating >= X
async function joinFeedbackRating(feedbackRating) {
    return await withOracleDB(async (connection) => {
        let query = `SELECT recipeName, feedbackComment, feedbackRating, instructions, calories FROM FEEDBACK
        JOIN VERSION ON VERSION.versionId = FEEDBACK.versionId AND VERSION.recipeId = FEEDBACK.recipeId
        JOIN RECIPE ON RECIPE.recipeId = VERSION.recipeId
        WHERE feedbackRating >= ${feedbackRating}`;
        const result = await connection.execute(query);
        return result.rows;
    }).catch((e) => {
        console.log("Error at joinFeedbackRating", e);
        return [];
    });
}

// PROJECTION
async function queryTable(tableName, columns) {
    return await withOracleDB(async (connection) => {
        let query = `SELECT ${columns} FROM ${tableName}`;
        const result = await connection.execute(query);
        return result;
    }).catch((e) => {
        console.log("Error at queryTable", e);
        return [];
    });
}

async function queryTableWhere(tableName, columns, where) {
    return await withOracleDB(async (connection) => {
        let query = `SELECT ${columns} FROM ${tableName} WHERE ${where}`;
        const result = await connection.execute(query);
        return result;
    }).catch((e) => {
        console.log("Error at queryTable", e);
        return [];
    });
}

// Aggregation with HAVING
async function aggregationHaving(count) {
    return await withOracleDB(async (connection) => {
        let query = `SELECT RECIPEID, 
                        COUNT(VERSIONID)
                        FROM VERSION 
                        GROUP BY RECIPEID 
                        HAVING COUNT(VERSIONID) >= ${count}`;
        const result = await connection.execute(query);
        return result.rows;
    }).catch((e) => {
        console.log("Error at aggregationHaving", e);
        return [];
    });
}

// AGGREGATION - GROUP BY: counts contributions of each userID in Feedback
async function countFeedbackByUser() {
    return await withOracleDB(async (connection) => {
        let query = `SELECT USERID, COUNT(FEEDBACKCOMMENT) FROM FEEDBACK GROUP BY USERID`;
        const result = await connection.execute(query);
        return result.rows;
    }).catch((e) => {
        console.log("Error at countFeedbackByUser", e);
        return [];
    });
}

// Nested Query
async function nestedQueryFeedback(age) {
    return await withOracleDB(async (connection) => {
        let query = `SELECT R.recipeName,
                            COUNT(F.feedbackRating) AS NumberOfRating,
                            AVG(F.feedbackRating) AS AvgRating
                    FROM FEEDBACK F, VERSION V, RECIPE R
                    WHERE F.versionID = V.versionID AND
                            F.recipeID = V.recipeID AND
                            R.recipeID = V.RECIPEID AND
                            F.userID IN (
                                SELECT U.userID
                                FROM USERINFO U, UserAge A
                                WHERE A.birthday = U.birthday AND
                                    A.age < ${age}
                            )
                    GROUP BY R.recipeName
                    ORDER BY AvgRating DESC`;
        const result = await connection.execute(query);
        return result;
    }).catch((e) => {
        console.log("Error at queryTable", e);
        return [];
    });
}

// Division
async function division() {
    return await withOracleDB(async (connection) => {
        let query = `SELECT Name, USERID
                        FROM USERINFO U
                        WHERE NOT EXISTS
                            ((SELECT F1.RECIPEID
                                FROM FEEDBACK F1)
                            MINUS
                            (SELECT F2.RECIPEID
                                FROM FEEDBACK F2
                                WHERE F2.USERID = U.USERID))`;
        const result = await connection.execute(query);
        return result.rows;
    }).catch((e) => {
        console.log("Error at division", e);
        return [];
    });
}

module.exports = {
    testOracleConnection,
    createTables,
    insertSamples,
    getTable,
    getRecipe,
    insertUser,
    insertMeal,
    deleteRecipe,
    updateFeedback,
    joinFeedbackRating,
    queryTable,
    aggregationHaving,
    getTableWithHeader,
    countFeedbackByUser,
    nestedQueryFeedback,
    queryTableWhere, 
    division
};