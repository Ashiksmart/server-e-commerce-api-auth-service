'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'GET',
    path: '/permission',
    options: {
        validate: {
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
                const { permissionService ,tokenService} = request.services()
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)

                let result = await permissionService.fetch(token)
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
