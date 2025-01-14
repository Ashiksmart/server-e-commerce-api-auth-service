'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const PartnerModel = require("../../models/account-partner-model")

module.exports = Helpers.withDefaults({
    method: 'PUT',
    path: '/partner/{id}',
    options: {
        validate: {
            params: Joi.object({
                id:Joi.string().required()
            }),
            payload: Joi.object({
                name: Joi.string().required().default(null),
                address: Joi.string().required().default(null),
                state:Joi.string().allow('').default("").optional(),
                city:Joi.string().allow('').default("").optional(),
                phone_number: Joi.number().integer().greater(0),
                description:  Joi.string().allow('').optional(),
                verify_items :Joi.string().valid('Y','N'),
                is_product_limit:Joi.string().valid('Y','N').optional(),
                product_limit: Joi.number().integer().default(0).optional(),
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
                request.payload = JSON.parse(Xss(JSON.stringify(request.payload)))
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { accountPartService , tokenService, commonServiceAuth} = request.services()
                const { mode , type } = request.server.app.constant
                
                let fetchPaylod = {
                    model:PartnerModel.tableName,
                    model_id:request.params.id,
                    field:JSON.parse(JSON.stringify(request.payload))
                  }
                let fetch = await commonServiceAuth.fetch(fetchPaylod)

                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await accountPartService.update(request.params,request.payload,token)
                if (result.statusCode == 204) {
                    const response = h.response(result);
                    response.code(204);
                    return response;
                } else if (result.statusCode == 200) {
                    let activityPayload = {
                        account_id:token?.payload.account_id,
                        model:PartnerModel.tableName,
                        model_id:[request.params.id],
                        payload:token?.payload,
                        oldobj:fetch,
                        newobj:fetchPaylod.field,
                        mode:mode.UPDATE
                      }
                      commonServiceAuth.centralLink(type.ACTIVITY,activityPayload)

                    return result;
                }else {
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