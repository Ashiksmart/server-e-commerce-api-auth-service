'use strict';

const Joi = require('joi');
const { Model } = require('./helpers');

module.exports = class ProjectPartnerAccount extends Model {

    static tableName = 'partner_account';

    static joiSchema = Joi.object({
        id: Joi.number().integer().greater(0),
        account_id: Joi.string().allow('').optional(),
        partner_id: Joi.string().allow('').optional(),
        name: Joi.string().required().allow('').optional(),
        username: Joi.string().allow('').optional(),
        email: Joi.string().email().allow('').optional(),
        address: Joi.string().required().allow('').optional(),
        state:Joi.string().allow('').default("").optional(),
        city:Joi.string().allow('').default("").optional(),
        phone_number: Joi.number().integer(),
        product_limit: Joi.number().integer().default(0).optional(),
        is_product_limit:Joi.string().valid('Y','N').default('N').optional(),
        product_utilize: Joi.number().default(0).optional(),
        account_license:Joi.string().valid('Y','N').optional(),
        verify_items:Joi.string().valid('Y','N').default('N'),
        active:Joi.string().valid('Y','N').allow('').optional(),
        description:Joi.string().default('').allow(""),
        account_req:Joi.string().valid('Y','N').optional(),
        created_by: Joi.string(),
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





