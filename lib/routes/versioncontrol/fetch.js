'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'GET',
    path: '/version',
    options: {
        validate: {
            query: Joi.object({
                type:Joi.string().required().valid('web','mob')
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

                const { versionControl , tokenService} = request.services()
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await versionControl.fetch(request.query,token)
                if (result.statusCode == 200) {
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