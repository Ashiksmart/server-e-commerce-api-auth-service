'use strict';

const Schmervice = require('@hapipal/schmervice');
const fs = require('fs');

const filePath = './collections/account_created.sql';


module.exports = class Accountqueryservice extends Schmervice.Service {

    async deploy(account_id){
        const knexInstance = this.server.knex();
        return await fs.readFile(filePath, 'utf8',async (err, data) => {
            if (err) {
            console.error(`Error reading file: ${err.message}`);
            return;
            }
        
            const modifiedData = data.replace(/'ACCOUNT_ID_MAPPING'/g, `'${account_id}'`);
        
            // Split the modified content into individual SQL statements
            const sqlStatements = modifiedData.split(';').filter(statement => statement.trim() !== '');
        
            // Function to execute batch SQL statements using Knex
            async function executeBatchSql(statements) {
            for (const statement of statements) {
                try {
                await knexInstance.raw(statement);
                //   console.log(`Statement executed successfully: ${statement}`);
                } catch (error) {
                console.error(`Error executing statement: ${statement}\nError: ${error.message}`);
                }
            }
            }
        console.log("sqlStatements: ",sqlStatements);
        
            // Execute the batch of SQL statements using Knex
            return await executeBatchSql(sqlStatements).then(() => {
            // Close the Knex connection
            //   knexInstance.destroy();
            console.log('Batch SQL executed successfully');
            
                let output = {
                    statusCode: 201
                } 
                return output
            }).catch((executeErr) => {
            console.error(`Error executing batch SQL: ${executeErr.message}`);
            // Close the Knex connection even if there is an error
            //   knexInstance.destroy();
            });
        });
    }

}