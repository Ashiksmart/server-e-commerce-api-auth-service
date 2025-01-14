'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const UserModel = require("../../models/user-model")

module.exports = Helpers.withDefaults({
    method: 'DELETE',
    path: '/user/{id}',
    options: {
        validate: {
            params: Joi.object({
                id: Joi.string()
            })
        },
        auth:  'jwt',
        // auth: {
        //     strategy: 'jwt',
        //     access: [{
        //         scope: ['permission:view']
        //     }]
        // },
        tags: ['api'],
        handler: async (request, h) => {
            try {
                request.params = JSON.parse(Xss(JSON.stringify(request.params)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { userservice , tokenService,commonServiceAuth} = request.services()
                const { mode , type } = request.server.app.constant
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await userservice.DeleteUser(request.params,token)
                if (result.statusCode == 200) {
                    let activityPayloadUser = {
                        account_id:token?.payload?.account_id,
                        model:UserModel.tableName,
                        model_id:[request.params.id],
                        payload:token?.payload,
                        mode:mode.DELETE
                      }
                    commonServiceAuth.centralLink(type.ACTIVITY,activityPayloadUser)

                    const response = h.response(result);
                    response.code(200);
                    return response;
                } else if (result.statusCode == 204) {
                    const response = h.response(result);
                    response.code(204);
                    return response;
                } else {
                    return result
                }
            } catch (error) {
                let Error = Boom.badImplementation('Bad implementation');
                return Error
            }

        }
    }
})