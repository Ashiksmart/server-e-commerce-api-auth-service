'use strict';

const Joi = require('joi');
const { Model } = require('./helpers');

module.exports = class VersionControl extends Model {

    static tableName = 'version_control';

    static joiSchema = Joi.object({
        id: Joi.number().integer().greater(0),
        account_id: Joi.string().required().default(null),
        major_version: Joi.number().default(0),
        minor_version: Joi.number().default(0),
        patch_version: Joi.number().default(0),
        message: Joi.string().default(null),
        type: Joi.string().valid('mob', 'web').required().default(null),
        redirect_url: Joi.string().default(null),
        active: Joi.string().required().valid('Y','N').default('Y'),
        created_by: Joi.string().required().default(null),
        updated_by: Joi.string().required().default(null),
        created_at: Joi.string().optional(),
        updated_at: Joi.string().optional(),
    });


    async $beforeInsert() {

        const now = new Date();
        this.updated_at = now;

    }

    async $beforeUpdate(opt, ctx) {

    }
};





