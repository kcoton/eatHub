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

async function fetchDemotableFromDb() {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute('SELECT * FROM DEMOTABLE');
        return result.rows;
    }).catch(() => {
        return [];
    });
}

async function initiateDemotable() {
    return await withOracleDB(async (connection) => {
        try {
            await connection.execute(`DROP TABLE DEMOTABLE`);
        } catch(err) {
            console.log('Table might not exist, proceeding to create...');
        }

        const result = await connection.execute(`
            CREATE TABLE DEMOTABLE (
                id NUMBER PRIMARY KEY,
                name VARCHAR2(20)
            )
        `);
        return true;
    }).catch(() => {
        return false;
    });
}

async function insertDemotable(id, name) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `INSERT INTO DEMOTABLE (id, name) VALUES (:id, :name)`,
            [id, name],
            { autoCommit: true }
        );

        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

async function updateNameDemotable(oldName, newName) {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute(
            `UPDATE DEMOTABLE SET name=:newName where name=:oldName`,
            [newName, oldName],
            { autoCommit: true }
        );

        return result.rowsAffected && result.rowsAffected > 0;
    }).catch(() => {
        return false;
    });
}

async function countDemotable() {
    return await withOracleDB(async (connection) => {
        const result = await connection.execute('SELECT Count(*) FROM DEMOTABLE');
        return result.rows[0][0];
    }).catch(() => {
        return -1;
    });
}

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

// Used to INSERT samle table
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

async function viewTable(tableName) {
    return await withOracleDB(async (connection) => {
        const query = `SELECT * FROM ${tableName}`
        console.log(query);
        const result = await connection.execute(`SELECT * FROM ${tableName}`);
        console.log('results: ', result);
        return result.rows;
    }).catch((err) => {
        console.log("error caught at getTable: ",err);
        return [];
    });
}

module.exports = {
    testOracleConnection,
    fetchDemotableFromDb,
    initiateDemotable, 
    insertDemotable, 
    updateNameDemotable, 
    countDemotable,
    insertSamples,
    viewTable,
    createTables
};