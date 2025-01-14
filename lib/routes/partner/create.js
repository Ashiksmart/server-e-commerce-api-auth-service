'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const UserModel = require("../../models/user-model")
const PartnerModel = require("../../models/account-partner-model")

module.exports = Helpers.withDefaults({
    method: 'POST',
    path: '/partner',
    options: {
        validate: {
            payload: Joi.object({
                account_id:Joi.string().optional(),
                name: Joi.string().required().default(null),
                username: Joi.string().required().default(null),
                email: Joi.string().email().default(null),
                address: Joi.string().required().default(null),
                state:Joi.string().allow('').default("").optional(),
                city:Joi.string().allow('').default("").optional(),
                phone_number: Joi.number().integer().greater(0),
                description:   Joi.string().allow('').optional(),
                verify_items :Joi.string().valid('Y','N').default('N').optional(),
                is_product_limit:Joi.string().valid('Y','N').default('N'),
                product_limit: Joi.number().integer().default(0),
            })
        },
        tags: ['api'],
        // auth:  'jwt',
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

                const { accountPartService, tokenService, commonServiceAuth } = request.services()
                const { mode , type } = request.server.app.constant
                let token = false
                if(request.headers.authorization != undefined){
                    token = await tokenService.TokenValidation(request.headers.authorization.split(" ")[1])
                }
                // let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await accountPartService.create(request.payload,token)
                if (result.statusCode == 201) {

                    let activityPayloadPartner = {
                        account_id:result.data.account_id,
                        model:PartnerModel.tableName,
                        model_id:[result.data.id],
                        payload:token?.payload,
                        mode:mode.CREATE
                      }
                    commonServiceAuth.centralLink(type.ACTIVITY,activityPayloadPartner)
                    let activityPayloadUser = {
                        account_id:result.data.account_id,
                        model:UserModel.tableName,
                        model_id:[result.data.user.id],
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