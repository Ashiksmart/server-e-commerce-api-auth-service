'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const UserModel = require("../../models/user-model")

module.exports = Helpers.withDefaults({
    method: 'PUT',
    path: '/user/{id}',
    options: {
        validate: {
            payload: Joi.object({
                first_name: Joi.string().optional(),
                last_name: Joi.string().optional(),
                phone_number: Joi.number().integer().greater(0).optional(),
                avatar_url: Joi.string().allow("").default("").optional(),
                user_group: Joi.number().optional(),
                additional_info: Joi.object().optional(),
            }),
            params: Joi.object({
                id: Joi.string()
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
                request.payload = JSON.parse(Xss(JSON.stringify(request.payload)));
                request.params = JSON.parse(Xss(JSON.stringify(request.params)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { userservice , tokenService, commonServiceAuth} = request.services()
                const { mode , type } = request.server.app.constant
                let fetchPaylod = {
                    model:UserModel.tableName,
                    model_id:request.params.id,
                    field:JSON.parse(JSON.stringify(request.payload))
                  }
                let fetch = await commonServiceAuth.fetch(fetchPaylod)

                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await userservice.UpdateUser(request.params,request.payload,token)
                if (result.statusCode == 200) {
                    let activityPayload = {
                        account_id:token?.payload.account_id,
                        model:UserModel.tableName,
                        model_id:[request.params.id],
                        payload:token?.payload,
                        oldobj:fetch,
                        newobj:fetchPaylod.field,
                        mode:mode.UPDATE
                      }
                      commonServiceAuth.centralLink(type.ACTIVITY,activityPayload)

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