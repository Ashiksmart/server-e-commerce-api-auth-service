'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const UserGroupModel = require("../../models/usergroup-model")

module.exports = Helpers.withDefaults({
    method: 'PUT',
    path: '/usergroup/{id}',
    options: {
        validate: {
            payload: Joi.object({
                name:Joi.string().required().optional(),
                description:Joi.string().required().optional(),
                permission_values:Joi.array().items(Joi.object({
                    category_name:Joi.string(),
                    params:Joi.array()
                })),
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


                const { userGroupService,tokenService,commonServiceAuth } = request.services()
                const { mode , type } = request.server.app.constant
                let fetchPaylod = {
                    model:UserGroupModel.tableName,
                    model_id:request.params.id,
                    field:JSON.parse(JSON.stringify(request.payload))
                  }
                let fetch = await commonServiceAuth.fetch(fetchPaylod)
                
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await userGroupService.update(request.params,request.payload,token)
                if (result.statusCode == 204) {
                    const response = h.response(result);
                    response.code(204);
                    return response;
                } else if (result.statusCode == 200) {
                    let activityPayload = {
                        account_id:token?.payload.account_id,
                        model:UserGroupModel.tableName,
                        model_id:[request.params.id],
                        payload:token?.payload,
                        oldobj:fetch,
                        newobj:fetchPaylod.field,
                        mode:mode.UPDATE
                      }
                    commonServiceAuth.centralLink(type.ACTIVITY,activityPayload)
                    return result;
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