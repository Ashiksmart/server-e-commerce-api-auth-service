'use strict';

const Schmervice = require('@hapipal/schmervice');
const Boom = require('@hapi/boom');
let { v4: uuidv4 } = require('uuid');

module.exports = class Accountservice extends Schmervice.Service {
    async create(payload) {
        try {
            let { ProjectAccount } = this.server.models()
            const { userservice , versionControl , accountqueryservice} = this.server.services()
            payload.account_id = uuidv4()
            payload.created_by = payload.email
            payload.updated_by = payload.email
            let main_domain = payload.domain
            let api_domain = payload.apidomain
            delete payload.domain
            delete payload.apidomain
            let create = await ProjectAccount.query().insert(payload)
            if (create) {
                let userdata = {
                    account_id: create.account_id,
                    first_name: `${create.username}_admin`,
                    email: `${create.email}`,
                    password: await this.passwordFormate(create.username),
                    roles: 'Superadmin',
                    auth: 'Y',
                    active: 'Y',
                    created_by: create.email,
                    updated_by: create.email
                }
                let veriondata= {
                    account_id:create.account_id,
                    major_version:1,
                    minor_version:0,
                    patch_version:0,
                    type:'web',
                    active:'Y',
                    created_by: create.email,
                    updated_by: create.email
                }
                let domaindata = {
                    account_id:create.account_id,
                    main_domain,
                    api_domain,
                    created_by: create.email,
                    updated_by: create.email
                }
                let versioncreate = await versionControl.create(veriondata)
                let admincreate = await userservice.CreateUser(userdata)
                let domaincreate = await this.createdomain(domaindata)
                await accountqueryservice.deploy(create.account_id)
                if (admincreate.statusCode == 201 && versioncreate.statusCode == 201 && domaincreate.statusCode == 201 ) {
                    create['user'] = { ...userdata}
                    create['version'] ={ ...veriondata}
                    let output = {
                        statusCode: 201,
                        message: "success",
                        data: create
                    }
                    return output
                }

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


    async fetch(token) {
        try {

            let condition = {}
            if (token !== undefined) {
                condition.account_id = token.payload.account_id
            }
            let fetch = await this.fetchAccount(condition)
            if (fetch.length > 0) {
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

    async fetchAccount(condition){
        try {
            let { ProjectAccount } = this.server.models();
            return await ProjectAccount.query().where(condition).limit(1)
        } catch (error) {
            console.log(error)
            const err = Boom.badRequest(error.name ? `${error.name}:${error.type}` : error.message);
            return err
        }
    }

    async updateAccount(params,payload){
        try {
            let { ProjectAccount } = this.server.models();
            delete payload.created_at
            delete payload.updated_at
            await ProjectAccount.query().where(params).update(payload)
        } catch (error) {
            console.log("Err",error)
            const err = Boom.badRequest(error.name ? `${error.name}:${error.type}` : error.message);
            return err
        }
    }



    async passwordFormate(data) {
        try {
            const pass = data.charAt(0).toUpperCase() + data.slice(1);
            return `${pass}@123`
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

    async fetchdomain(params){
        try {

            let { ProjectAccountDomain } = this.server.models()
            const { permissionService , tokenService} = this.server.services()
            let condition = {}
            if (params.domain !== undefined &&params.domain !== "" && params.domain ) {
                condition.main_domain = params.domain
            }
            let fetch = await ProjectAccountDomain.query().where(condition).limit(1)
            if (fetch.length > 0) {
                let account_info = await this.fetchAccount({account_id:fetch[0].account_id})
                fetch[0].name = account_info[0].name
                fetch[0].primay_logo = account_info[0].primay_logo
                fetch[0].secondary_logo = account_info[0].secondary_logo
                fetch[0].primay_color = account_info[0].primay_color
                fetch[0].secondary_color = account_info[0].secondary_color
                fetch[0].is_partner = account_info[0].is_partner
                fetch[0].client_partner_request = account_info[0].client_partner_request
                fetch[0].client_employee_request = account_info[0].client_employee_request
                fetch[0].team_auto_assign = account_info[0].team_auto_assign
                fetch[0].is_user_limit = account_info[0].is_user_limit
                fetch[0].user_limit = account_info[0].user_limit
                fetch[0].user_utilize = account_info[0].user_utilize
                let scopedata ={
                    account_id:fetch[0].account_id,
                    email:account_info[0].email,
                    scope :  await  permissionService.scopermission({account_id:fetch[0].account_id})
                }
                
                fetch[0].temp_token = await tokenService.TokenGenarate(scopedata,false);
                let output = {
                    statusCode: 200,
                    message: "success",
                    data: fetch[0]
                }
                return output
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

    async createdomain(payload){
        try {

            let { ProjectAccountDomain } = this.server.models()
            let create = await ProjectAccountDomain.query().insert(payload)
            if (create) {
                let output = {
                    statusCode: 201,
                    message: "success",
                    data: create
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