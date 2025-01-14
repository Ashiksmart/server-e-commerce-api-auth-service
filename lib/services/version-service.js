const Schmervice = require('@hapipal/schmervice');
let Boom = require('@hapi/boom');



module.exports = class VersionControl extends Schmervice.Service {

    async create(payload){
        try {
            let { VersionControl } = this.server.models()
            let create = await VersionControl.query().insert(payload)
            if (create) {
                let output = {
                    statusCode: 201,
                    message: "success",
                    data: create
                }
                return output
            }else{
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

    async fetch(query,token){
        try {
            let { VersionControl } = this.server.models()
        let condition={account_id:token.payload.account_id}

        if(query.type != undefined && query.type !=="" && query.type){
            condition.type = query.type
        }


        let fetch = await VersionControl.query().where(condition).select('*').orderBy('minor_version', "desc").orderBy('major_version', "desc").orderBy('patch_version', "desc").limit(1)
        if (fetch.length>0) {
            let output = {
                statusCode: 200,
                message: "success",
                data: fetch
            }
            return output
        } else {
            let output = {
                statusCode: 204,
                message: "No Content"
            }
            return output
        }

        console.log(fetch)
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