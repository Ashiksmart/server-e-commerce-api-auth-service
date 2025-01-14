'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'POST',
    path: '/otp',
    options: {
        validate: {
            payload: Joi.object({
                email: Joi.string().email().optional(),
                type:Joi.number().integer().optional(),
                phone_number: Joi.number().integer().greater(0).optional(),
                account_id: Joi.string().required()
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

                const { otpservice } = request.services()
                let result = await otpservice.create(request.payload)
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