'use strict';
const Helpers = require('../helpers');
let Boom = require('@hapi/boom')
const Joi = require('joi');
var Xss = require("xss");

module.exports = Helpers.withDefaults({
    method: 'GET',
    path: '/account/domain/{domain}',
    options: {
        validate: {
            params: Joi.object({
                domain:Joi.string().required()
            }),
        },
        tags: ['api'],
        auth:  false,
        handler: async (request, h) => {
            try {
                request.params = JSON.parse(Xss(JSON.stringify(request.params)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {
                const { accountservice } = request.services()
                let result = await accountservice.fetchdomain(request.params)
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