'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const UserGroupModel = require("../../models/usergroup-model")

module.exports = Helpers.withDefaults({
    method: 'DELETE',
    path: '/usergroup/{id}',
    options: {
        validate: {
            params: Joi.object({
                id:Joi.string()
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
                request.params = JSON.parse(Xss(JSON.stringify(request.params)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { userGroupService,tokenService,commonServiceAuth } = request.services()
                const { mode , type } = request.server.app.constant
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await userGroupService.delete(request.params,token)
                if (result.statusCode == 200) {
                    let activityPayloadUser = {
                        account_id:token?.payload?.account_id,
                        model:UserGroupModel.tableName,
                        model_id:[request.params.id],
                        payload:token?.payload,
                        mode:mode.DELETE
                      }
                    commonServiceAuth.centralLink(type.ACTIVITY,activityPayloadUser)

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