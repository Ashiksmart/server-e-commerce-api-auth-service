'use strict';
const Helpers = require('../helpers');
const Joi = require('joi');
let Boom = require('@hapi/boom')
var Xss = require("xss");
const PartnerModel = require("../../models/account-partner-model")

module.exports = Helpers.withDefaults({
    method: 'DELETE',
    path: '/partner/{id}',
    options: {
        validate: {
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
                request.params = JSON.parse(Xss(JSON.stringify(request.params)));
            } catch (err) {
                const error = Boom.badRequest('Invalid Input');
                return error;
            }
            try {

                const { accountPartService, tokenService , commonServiceAuth } = request.services()
                const { mode , type } = request.server.app.constant

                let token = await tokenService.TokenValidation(request.auth.artifacts.token)
                let result = await accountPartService.delete(request.params,token)
                if (result.statusCode == 200) {
                    let activityPayloadPartner = {
                        account_id:token?.payload?.account_id,
                        model:PartnerModel.tableName,
                        model_id:[request.params.id],
                        payload:token?.payload,
                        mode:mode.DELETE
                      }
                    commonServiceAuth.centralLink(type.ACTIVITY,activityPayloadPartner)

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