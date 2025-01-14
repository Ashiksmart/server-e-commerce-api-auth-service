'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'GET',
    path: '/user',
    options: {
        validate: {
            query: Joi.object({
                id:Joi.string().optional(),
                partner_id:Joi.string().optional(),
                roles:Joi.string().optional().valid('SubSuperadmin','Admin','SubAdmin','Employee','Client'),
                user_group: Joi.string().optional(),
                direction: Joi.string().optional().valid('asc', 'desc'),
                page: Joi.number().min(1).optional(),
                limit: Joi.number().optional(),
            })
        },
        tags: ['api'],
        auth:  'jwt',
        // auth: {
        //     strategy: 'jwt',
        //     access: [{
        //         scope: ['permission:view']
        //     }]
        // },
        handler: async (request, h) => {
            try {
                request.query = JSON.parse(Xss(JSON.stringify(request.query)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {
                const { userservice , tokenService} = request.services()
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await userservice.FetchUser(request.query,token)
                if (result.statusCode == 204) {
                    const response = h.response(result);
                    response.code(204);
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