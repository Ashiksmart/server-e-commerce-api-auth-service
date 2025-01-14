'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'GET',
    path: '/partner',
    options: {
        validate: {
            query: Joi.object({
               page:Joi.number().min(1).optional(),
               limit:Joi.number().optional(),
               direction:Joi.string().valid('asc','desc'),
               name:Joi.string().optional(),
               active:Joi.string().valid('Y','N').optional(),
               id:Joi.string().optional(),
               partner_id:Joi.string().optional(),
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

                const { accountPartService,tokenService } = request.services()
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await accountPartService.fetch(request.query,token)
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