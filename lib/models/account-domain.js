'use strict';

const Joi = require('joi');
const { Model } = require('./helpers');

module.exports = class ProjectAccountDomain extends Model {

    static tableName = 'project_domain';

    static joiSchema = Joi.object({
        id: Joi.number().integer().greater(0),
        account_id: Joi.string().required().default(null),
        main_domain:Joi.string().required().default(null),
        api_domain: Joi.object().required(),
        created_by: Joi.string().required().default(null),
        updated_by: Joi.string().required().default(null),
        created_at: Joi.string().optional(),
        updated_at: Joi.string().optional(),
    });


    $beforeInsert() {
        
    }

    $beforeUpdate() {


        
    }

};





