'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const UserModel = require("../../models/user-model")

module.exports = Helpers.withDefaults({
    method: 'POST',
    path: '/user',
    options: {
        validate: {
            payload: Joi.object({
                account_id: Joi.string().optional(),
                partner_id: Joi.string().optional().default(null),
                first_name: Joi.string().required(),
                last_name:Joi.string().optional().allow(''),
                roles: Joi.string().valid('Admin','SubAdmin','Employee','Client').required(),
                email: Joi.string().required().email(),
                phone_number: Joi.number().integer().greater(0),
                avatar_url: Joi.string().allow("").default("").optional(),
                user_group: Joi.number().default(null),
                auth: Joi.string().default('N').valid('Y','N'),
                password: Joi.string().required(),
                additional_info: Joi.object(),
            })
        },
        tags: ['api'],
        handler: async (request, h) => {
            try {
                request.payload = JSON.parse(Xss(JSON.stringify(request.payload)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { userservice,tokenService,commonServiceAuth } = request.services()
                const { mode , type } = request.server.app.constant
                let token = false
                if(request.headers.authorization != undefined){
                    token = await tokenService.TokenValidation(request.headers.authorization.split(" ")[1])
                }
                let result = await userservice.CreateUser(request.payload,request)
                if (result.statusCode == 201) {
                    let activityPayloadUser = {
                        account_id:result.data.account_id,
                        model:UserModel.tableName,
                        model_id:[result.data.id],
                        payload:token?.payload,
                        mode:mode.CREATE
                    }
                    commonServiceAuth.centralLink(type.ACTIVITY,activityPayloadUser)

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