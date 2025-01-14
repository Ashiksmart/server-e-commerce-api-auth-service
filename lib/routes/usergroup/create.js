'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const UserGroupModel = require("../../models/usergroup-model")
module.exports = Helpers.withDefaults({
    method: 'POST',
    path: '/usergroup',
    options: {
        validate: {
            payload: Joi.object({
                partner_id: Joi.string().required().optional().allow(null),
                name:Joi.string().required().optional(),
                description:Joi.string().optional(),
                permission_values:Joi.array().items(Joi.object({
                    category_name:Joi.string(),
                    params:Joi.array()
                })),
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
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { userGroupService,tokenService,commonServiceAuth } = request.services()
                const { mode , type } = request.server.app.constant
                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await userGroupService.create(request.payload,token)
                if (result.statusCode == 201) {
                    let activityPayload = {
                        account_id:result.data.account_id,
                        model:UserGroupModel.tableName,
                        model_id:[result.data.id],
                        payload:token?.payload,
                        mode:mode.CREATE
                    }
                    commonServiceAuth.centralLink(type.ACTIVITY,activityPayload)

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