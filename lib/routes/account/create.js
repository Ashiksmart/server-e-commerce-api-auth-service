'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'POST',
    path: '/account',
    options: {
        validate: {
            payload: Joi.object({
                name: Joi.string().required().default(null),
                username: Joi.string().required().default(null),
                email: Joi.string().email().default(null),
                address: Joi.string().required().default(null),
                phone_number: Joi.number().integer().greater(0),
                primay_logo: Joi.string().required().default(null),
                secondary_logo: Joi.string().required().default(null),
                primay_color: Joi.string().required().default(null),
                secondary_color: Joi.string().required().default(null),
                storage_service: Joi.string().required().default('N').valid('Y','N'),
                app_url: Joi.string().required().default(null),
                app_discription: Joi.string().required().default(null),
                process: Joi.string().required().default(null),
                currency: Joi.string().required().default(null),
                domain:Joi.string().required(),
                apidomain: Joi.object().required(),
                is_product_limit:Joi.string().required().default('N').valid('Y','N'),
                description:  Joi.string().allow('').optional(),
                product_limit: Joi.number().integer().default(0).optional(),
                is_partner_limit:Joi.string().required().default('N').valid('Y','N'),
                partner_limit:Joi.number().integer().default(0).optional(),
                is_partner:Joi.string().required().default('N').valid('Y','N'),
                client_partner_request:Joi.string().default('N').valid('Y','N'),
                client_employee_request:Joi.string().default('N').valid('Y','N'),
                team_auto_assign:Joi.string().default('N').valid('Y','N'),
                is_user_limit:Joi.string().default('N').valid('Y','N'),
                user_limit:Joi.number().integer().default(0).optional()
            })
        },
        tags: ['api'],
        handler: async (request, h) => {
            try {
                request.payload = JSON.parse(Xss(JSON.stringify(request.payload)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { accountservice } = request.services()
                let result = await accountservice.create(request.payload)
                if (result.statusCode == 201) {
                    const response = h.response(result);
                    response.code(201);
                    return response;
                } else {
                    return result
                }
            } catch (error) {
                console.log(error)
                let Error = Boom.badImplementation('Bad implementation');
                return Error
            }

        }
    }
})