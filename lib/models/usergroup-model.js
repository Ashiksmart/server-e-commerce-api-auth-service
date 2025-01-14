'use strict';

const Joi = require('joi');
const { Model } = require('./helpers');

module.exports = class UserGroup extends Model {

    static tableName = 'usergroup';

    static joiSchema = Joi.object({
        id: Joi.number().integer().greater(0),
        account_id: Joi.string().required(),
        partner_id: Joi.string().optional().default(null).allow(null),
        name:Joi.string().required().optional(),
        description:Joi.string().optional().default(""),
        active:Joi.string().valid('Y','N').optional(),
        permission_values:Joi.array().items(Joi.object({
            category_name:Joi.string(),
            params:Joi.array()
        })),
        created_by: Joi.string().optional(),
        updated_by: Joi.string().required(),
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





