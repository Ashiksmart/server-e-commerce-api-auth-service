'use strict';

const Schmervice = require('@hapipal/schmervice');
const Boom = require('@hapi/boom');
let { v4: uuidv4 } = require('uuid');

module.exports = class Otpservice extends Schmervice.Service {
    async create(payload) {
        try {
            let { OneTimePassword } = this.server.models()
            payload.otp = Math.floor(Math.random() * 999999)
            let create = await OneTimePassword.query().insert(payload)
            if (create) {
                let output = {
                    statusCode: 201,
                    message: "success",
                    data: create
                }
                return output
            } else {
                return Boom.badRequest();
            }

        } catch (error) {
            console.log(error)
            if (error.nativeError.sqlState == '23000') {
                return Boom.conflict()
            } else {
                const err = Boom.badRequest(error.name ? `${error.name}:${error.type}` : error.message);
                return err
            }
        }
    }


    async fetch(payload) {
        try {

            let { OneTimePassword } = this.server.models()

            let fetch = await OneTimePassword.query().where(payload).orderBy('id',"desc").limit(1).offset(0)
            console.log(fetch,payload)
            if (fetch.length > 0) {
                let delete_ = await OneTimePassword.query()
                    .where({"id":fetch[0].id}).del();
                if (delete_) {
                    let output = {
                        statusCode: 200,
                        message: "success",
                        data: fetch
                    }
                    return output
                }

            } else {
                let output = {
                    statusCode: 204,
                    message: "No Content"
                }
                return output
            }

        } catch (error) {
            console.log(error)
            if (error.nativeError.sqlState == '23000') {
                return Boom.conflict()
            } else {
                const err = Boom.badRequest(error.name ? `${error.name}:${error.type}` : error.message);
                return err
            }
        }
    }

}