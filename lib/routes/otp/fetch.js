'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'GET',
    path: '/otp',
    options: {
        validate: {
            query: Joi.object({
                email: Joi.string().email().optional(),
                phone_number: Joi.number().integer().greater(0).optional(),
                account_id: Joi.string().required(),
                otp:Joi.number().integer().greater(0).required(),
            })
        },
        tags: ['api'],
        handler: async (request, h) => {
            try {
                request.query = JSON.parse(Xss(JSON.stringify(request.query)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { otpservice } = request.services()
                let result = await otpservice.fetch(request.query)
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