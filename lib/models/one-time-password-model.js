'use strict';

const Joi = require('joi');
const { Model } = require('./helpers');

module.exports = class OneTimePassword extends Model {
  static tableName = "one_time_password";

  static joiSchema = Joi.object({
    id: Joi.number().integer().greater(0),
    account_id: Joi.string().required(),
    type: Joi.number().optional(),
    email: Joi.string().email().optional(),
    phone_number: Joi.number().integer().greater(0).optional(),
    additional_info: Joi.object().optional(),
    created_at: Joi.string().optional(),
    updated_at: Joi.string().optional(),
    otp:Joi.number().integer().greater(0).required(),
  });

  async $beforeInsert() {
    const now = new Date();
    this.updated_at = now;
   
  }

  async $beforeUpdate() {
    
   
  }

};





