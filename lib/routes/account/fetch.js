'use strict';
const Helpers = require('../helpers');
let Boom = require('@hapi/boom')

module.exports = Helpers.withDefaults({
    method: 'GET',
    path: '/account',
    options: {
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
                const { accountservice, tokenService } = request.services()
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await accountservice.fetch(token)
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