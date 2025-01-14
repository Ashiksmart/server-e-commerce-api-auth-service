'use strict';

const Joi = require('joi');
const { Model } = require('./helpers');

module.exports = class ProjectAccount extends Model {

    static tableName = 'project_account';

    static joiSchema = Joi.object({
        id: Joi.number().integer().greater(0),
        account_id: Joi.string().required().default(null),
        name: Joi.string().required().default(null),
        username: Joi.string().required().default(null),
        email: Joi.string().email().default(null),
        address: Joi.string().required().default(null),
        phone_number: Joi.number().integer().greater(0),
        is_product_limit:Joi.string().required().default('N').valid('Y','N'),
        product_limit: Joi.number().integer().default(0).optional(),
        product_utilize: Joi.number().default(0).optional(),
        is_partner:Joi.string().required().default('N').valid('Y','N'),
        is_partner_limit:Joi.string().required().default('N').valid('Y','N'),
        partner_limit:Joi.number().integer().default(0).optional(),
        partner_utilize:Joi.number().integer().default(0).optional(),
        description:Joi.string().default('').allow(""),
        primay_logo: Joi.string().required().default(null),
        secondary_logo: Joi.string().required().default(null),
        primay_color: Joi.string().required().default(null),
        secondary_color: Joi.string().required().default(null),
        storage_service:Joi.string().required().default('N').valid('Y','N'),
        app_url: Joi.string().required().default(null),
        app_discription: Joi.string().required().default(null),
        process: Joi.string().required().default(null),
        currency:Joi.string().allow('').optional(),
        client_partner_request:Joi.string().required().default('N').valid('Y','N'),
        client_employee_request:Joi.string().required().default('N').valid('Y','N'),
        team_auto_assign:Joi.string().required().default('N').valid('Y','N'),
        is_user_limit:Joi.string().required().default('N').valid('Y','N'),
        user_limit:Joi.number().integer().default(0).optional(),
        user_utilize:Joi.number().integer().optional(),
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





