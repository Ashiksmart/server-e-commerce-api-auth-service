'use strict';

const Schmervice = require('@hapipal/schmervice');
const Boom = require('@hapi/boom');

module.exports = class Userservice extends Schmervice.Service {



    async CreateUser(payload,request) {
        try {
            let scope = this;
            let { Users } = scope.server.models();
            let { tokenService , permissionService, accountservice } = scope.server.services();
            let accountinfo = await accountservice.fetchAccount({account_id:payload.account_id})
            let token
            if ((payload.roles == "Admin" || payload.roles == "SubAdmin" ) && request.headers.authorization == undefined) {
                return Boom.unauthorized('Token missing')
            }else if(request!== undefined && request.headers.authorization !== undefined && (payload.roles == "Admin" || payload.roles == "SubAdmin" || payload.roles == "Employee")){
                let EncodeToken = request.headers.authorization.split(" ")[1]
                token = await tokenService.TokenValidation(EncodeToken)
            }
            
            if((payload.roles == "Admin" || payload.roles == "SubAdmin" || payload.roles == "Employee" ) && (token != undefined && token.isValid)){
                payload.account_id = token.payload.account_id
                payload.partner_id = token.payload.partner_id
                payload.created_by = token.payload.email
                payload.updated_by = token.payload.email
                payload.active = "Y"
            }else if(payload.roles == "Client"){                 
                if(accountinfo[0].is_user_limit == "Y" && accountinfo[0].user_utilize - accountinfo[0].user_limit == 0){
                    return Boom.badRequest('Client Role User Limit Reached');
                }
                payload.created_by = payload.email
                payload.updated_by = payload.email
                payload.last_login = new Date()
                payload.status = "login"
                payload.active = "Y"
                // delete payload.user_group
            }else if(payload.roles == "Employee"){
                payload.created_by = payload.email
                payload.updated_by = payload.email
                payload.active = "Y"
                
            }

            let create = await Users.query().insert(payload)
            let { id,account_id,partner_id , first_name ,last_name="", roles ,email,user_group } = create
            let Grouppayload = {
                id,
                account_id,
                partner_id,
                first_name,
                last_name,
                roles,
                email,
                user_group
            }
            let scopes= await  permissionService.scopermission(Grouppayload)
            Grouppayload.scope = scopes;
            let tokengen = await tokenService.TokenGenarate(Grouppayload,true);
            create.token = tokengen
            delete create.password
            if(create){
                if(payload.roles == "Client"){ 
                    if(accountinfo[0].is_user_limit == "Y" && accountinfo[0].user_limit - accountinfo[0].user_utilize > 0){
                        accountservice.updateAccount({account_id},{...accountinfo[0],user_utilize:accountinfo[0].user_utilize + 1})
                    }
                }   
                let output = {
                    statusCode: 201,
                    message: "success",
                    data: create
                }
                return output
            }else{
                return Boom.badRequest('bad request');
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


    async FetchUser(query,token) {
        try {
            let { Users } = this.server.models();      
            let page = 0;
            let limit = 10;
            let condition = {
              active: "Y",
              partner_id: token.payload.partner_id,
            };
            let direction = "desc";

            if ((token.payload.roles == "Superadmin" || token.payload.roles == "Client" || token.payload.roles == "Admin" || token.payload.roles == "SubAdmin" || token.payload.roles == "SubSuperadmin" || token.payload.roles == "Employee") && query.roles == undefined) {
                condition.id = token.payload.id
            }

            if (query.id !== "" && query.id !== undefined && query.id) {
                condition.id = query.id
            }

            if (query.roles != undefined && query.roles != "" && query.roles) {
                condition.roles = query.roles;
            }

            if (query.limit != undefined && query.limit != "" && query.limit) {
                limit = query.limit;
            }
        
            if (query.page != undefined && query.page != "" && query.page) {
                page = limit*(query.page-1);
            }
  
            if (query.direction != undefined && query.direction != "" && query.direction) {
                direction = query.direction;
            }
            if(token.payload.roles == "Superadmin" || token.payload.roles == "SubSuperadmin"){
                if (query.active != undefined && query.active != "" && query.active) {
                    condition.active = query.active;
                }      
                
            }

           

            if(token.payload.roles == "Superadmin"){
                if (query.partner_id != undefined && query.partner_id != "" && query.partner_id) {
                    condition.partner_id = query.partner_id;
                }
            }

            
            condition.account_id = token.payload.account_id;
            let fetch = await Users.query()
              .where(condition)
              .select(["id",
                "account_id",
                "partner_id",
                "first_name",
                "last_name",
                "roles",
                "email",
                "phone_number",
                "avatar_url",
                "user_group",
                "auth",
                "active",
                "last_login",
                "status",
                "additional_info",
                "created_by",
                "updated_by",
                "created_at",
                "updated_at",])
              .offset(page)
              .limit(limit)
              .orderBy("id", direction);
            let count = await Users.query().where(condition).count("id as count");
            if (fetch.length > 0) {
              let output = {
                statusCode: 200,
                message: "success",
                count: count[0].count,
                page:page,
                limit:limit,
                direction,
                data: fetch,
              };
              return output;
            } else {
              let output = {
                statusCode: 204,
                message: "No Content",
              };
              return output;
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


    async UpdateUser(params,payloadData,token) {
        try {
            let payload = JSON.parse(JSON.stringify(payloadData))
            payload.updated_by = token.payload.email
            params.account_id = token.payload.account_id
            // params.partner_id = token.payload.partner_id
            let update = await this.Update(params,payload)
            if (update) {
                let output = {
                    statusCode: 200,
                    message: "success",
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

    async DeleteUser(params,token) {
        try {
            let payload ={active : "N"}
            return await this.UpdateUser(params,payload,token)
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


    async Update(params,payload){
        try {
            let { Users } = this.server.models();
            return await Users.query().where(params).update(payload)
        } catch (error) {
            console.log(error)
            const err = Boom.badRequest(error.name ? `${error.name}:${error.type}` : error.message);
            return err
        }
    }
}
