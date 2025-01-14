'use strict';

const Joi = require('joi');
const { Model } = require('./helpers');

module.exports = class Permission extends Model {

    static tableName = 'permission';

    static joiSchema = Joi.object({
        id: Joi.number().integer().greater(0),
        account_id: Joi.string().required().default(null),
        category_name:Joi.string().required().default(null),
        permission:Joi.array().items(Joi.object({
            name:Joi.string(),
            value:Joi.string()
        })),
        default:Joi.string(),
        active:Joi.string().valid('Y','N').default('Y'),
        created_by: Joi.string().required().default(null),
        updated_by: Joi.string().required().default(null),
        created_at: Joi.string().optional(),
        updated_at: Joi.string().optional(),
    });


    $beforeInsert() {
        const now = new Date();
        this.updated_at = now;
        
    }

    $beforeUpdate() {


        
    }

};





