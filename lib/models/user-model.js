'use strict';

const Joi = require('joi');
const { Model } = require('./helpers');
const SecurePassword = require('secure-password');
const Util = require('util');

let pwd = new SecurePassword();
pwd = {
    hash: Util.promisify(pwd.hash.bind(pwd)),
    verify: Util.promisify(pwd.verify.bind(pwd))
};
module.exports = class Users extends Model {
  static tableName = "user";

  static joiSchema = Joi.object({
    id: Joi.number().integer().greater(0),
    account_id: Joi.string().optional(),
    partner_id: Joi.string().allow(null),
    roles: Joi.string().valid('Superadmin','Admin','Employee','SubSuperadmin','SubAdmin','Client'),
    first_name:Joi.string().optional(),
    last_name:Joi.string().optional().allow(''),
    email: Joi.string().email().optional(),
    phone_number: Joi.number().integer().greater(0).optional(),
    avatar_url: Joi.string().allow("").default("").optional(),
    user_group: Joi.number().optional().allow(null),
    auth: Joi.string().valid('Y','N').optional(),
    active: Joi.string().valid('Y','N').optional(),
    last_login: Joi.date().optional(),
    status: Joi.string().optional(),
    password: Joi.binary().optional(),
    additional_info: Joi.object().optional(),
    created_by: Joi.string().optional(),
    updated_by: Joi.string().required(),
    created_at: Joi.string().optional(),
    updated_at: Joi.string().optional(),
  });

  async $beforeInsert() {
    const now = new Date();
    this.updated_at = now;
    this.password = await pwd.hash(Buffer.from(this.password));
  }

  async $beforeUpdate() {
    if(this.password != undefined){
      this.password = await pwd.hash(Buffer.from(this.password));
    }
   
  }

  static async PasswordCompare(pass,dbpass,cb) {
    const passwordCheck = await pwd.verify(
      Buffer.from(pass),
      dbpass
    );
    switch (passwordCheck) {
      case SecurePassword.INVALID:
        return cb(401);
      case SecurePassword.VALID:
        return cb(200);
      case SecurePassword.VALID_NEEDS_REHASH:
        return cb(202);
    }
  }
};





