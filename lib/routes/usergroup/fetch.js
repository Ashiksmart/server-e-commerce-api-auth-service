'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'GET',
    path: '/usergroup',
    options: {
        validate: {
            query: Joi.object({
                id:Joi.string().optional(),
                name:Joi.string().optional(),
                page:Joi.number().min(1).optional(),
                limit:Joi.number().optional(),
		        partner_id:Joi.string().optional().default(null),
                active:Joi.string().valid('Y','N').optional(),
                direction: Joi.string().optional().valid('asc', 'desc')
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


                const { userGroupService,tokenService } = request.services()
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await userGroupService.fetch(request.query,token)
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