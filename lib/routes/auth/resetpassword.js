'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'POST',
    path: '/auth/password',
    options: {
        validate: {
            payload: Joi.object({
                account_id:Joi.string().optional(),
                email:Joi.string().optional(),
                token:Joi.string().optional(),
                password:Joi.string().optional(),
                id:Joi.number().optional(),
                roles:Joi.string().valid('Superadmin','Admin','SubSuperadmin','SubAdmin','Employee','Client').required()

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

                const { authService } = request.services()
                let result = await authService.ResetPasswordUser(request.payload,request)
                if (result.statusCode == 200) {
                    const response = h.response(result);
                    response.code(200);
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