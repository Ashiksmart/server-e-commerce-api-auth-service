'use strict';

const Schmervice = require('@hapipal/schmervice');
const Boom = require('@hapi/boom');

module.exports = class AuthService extends Schmervice.Service {

    async login(payload) {
        try {

            let scope = this;
            let { Users } = scope.server.models();
            let { tokenService , userservice , permissionService} = scope.server.services();

            payload.email = payload.username
            delete payload.username
            let password = payload.password
            delete payload.password
            let fetch = await Users.query().where(payload).select(["id",
            "account_id",
            "partner_id",
            "first_name",
            "last_name",
            "roles",
            "email",
            "user_group",
            "auth",
            "active",
            "password"]).limit(1)
            if(fetch.length >0){
                if(fetch[0].auth == "Y"){
                    if(fetch[0].active == "Y"){
                        let output ={
                            statusCode :200,
                            message: "Login success",
                            token:""
                        }
                       return Users.PasswordCompare(password,fetch[0].password, async function (IsMatch){
                            delete fetch[0].active
                            delete fetch[0].auth
                            delete fetch[0].password
                            let tokenres
                            let payload = {}
                            let params = {id:fetch[0].id}
                            if(IsMatch == 200){
                                payload= {
                                status:"Login",
                                last_login:new Date(),
                                updated_by:fetch[0].email
                                }
                                let updatepass = await userservice.Update(params,payload)
                                if(updatepass == 1){
                                    // based roles need to handel need permission
                                    let scopes= await  permissionService.scopermission(fetch[0])
                                    fetch[0].scope= scopes
                                    tokenres = await tokenService.TokenGenarate(fetch[0],true)
                                }else{
                                   return Boom.badRequest("No Uesr Found")
                                }
                               
                            }else if(IsMatch == 202){
                                
                                 payload = { 
                                 status:"Login",
                                 last_login:new Date(),
                                 password:password,
                                 updated_by:fetch[0].email
                                }
                                 let updatepass = await userservice.Update(params,payload)
                                 if(updatepass == 1){
                                     // based roles need to handel need permission
                                     let scopes= await  permissionService.scopermission(fetch[0])
                                    fetch[0].scope= scopes
                                    tokenres = await tokenService.TokenGenarate(fetch[0],true)
                                 }else{
                                    Boom.badRequest("No User Found")
                                 }
                                 
                            }else{
                                return Boom.unauthorized('Invalid Password')
                            }
                            if(tokenres){
                                output.token = tokenres
                                return output
                            }
                        })

                    }else{
                        return Boom.unauthorized('User Inactive')
                    }
                }else{
                    return Boom.unauthorized('User Not Activation')
                }
            }else{
                return Boom.unauthorized('User Does Not Exist')
            }
            

        } catch (error) {
            console.log(error)
     
                const err = Boom.badRequest(error.name ? `${error.name}:${error.type}` : error.message);
                return err

        }
    }

    async logout(token){
        try {
            let scope = this;
            let { Users } = scope.server.models();
            let { userservice} = scope.server.services();

            let UserData={
                id:token.payload.id,
                account_id:token.payload.account_id,
                partner_id:token.payload.partner_id
            }

            let fetch = await Users.query().where(UserData).select(["id",
            "account_id",
            "partner_id",
            "first_name",
            "last_name",
            "roles",
            "email",
            "user_group",
            "auth",
            "active",
            ]).limit(1)
            if(fetch.length > 0){
                let payload ={
                    status:"Logout",
                    updated_by:fetch[0].email
                }
                let updatepass = await userservice.Update(UserData,payload)
                if(updatepass == 1){
                    let output = {
                        statusCode: 200,
                        message: "Logout success"
                    }
                    return output
                }
                
            }else {
                const error = Boom.badRequest("No User Found")
                return error;
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

    async ResetPasswordUser(payload,request){
        try {
            let scope = this;
            let { Users } = scope.server.models();
            let { tokenService , userservice, permissionService} = scope.server.services();
            let UserData = {account_id:payload.account_id , email:payload.email,id:payload.id,roles:payload.roles}
            Object.keys(UserData).forEach(key => UserData[key] === undefined ? delete UserData[key] : {});
            let fetch = await Users.query().where(UserData).select(["id",
            "account_id",
            "partner_id",
            "first_name",
            "last_name",
            "roles",
            "email",
            "user_group",
            "auth",
            "active",
            ]).limit(1)
            if(fetch.length > 0){
                if (payload.account_id && payload.email && !payload.token && !payload.password) {
                    let tokenpaylod = {
                        account_id: fetch[0].account_id,
                        partner_id: fetch[0].partner_id,
                        id: fetch[0].id,
                        role: fetch[0].role,
                        first_name:fetch[0].first_name,
                        last_name:fetch[0].last_name,
                        scope: "openid profile offline_access"
                    }
                    let token = await tokenService.TokenGenarate(tokenpaylod,true,604800)
                    delete payload.email
                    payload.token = token
                    let output = {
                        statusCode: 200,
                        message: "Temp Token success",
                        data: payload
                    }
                    return output
                }else if(payload.account_id && payload.token && payload.password && payload.email){
                  let TokenValidation =  await tokenService.TokenValidation(payload.token)
                  if(TokenValidation.isValid){
                    let params =  {
                        id :TokenValidation.payload.id,
                        account_id:TokenValidation.payload.account_id,
                        partner_id:TokenValidation.payload.partner_id
                    }
                    let payloadata ={
                        partner_id:TokenValidation.payload.partner_id,
                        auth: "Y",
                        password: payload.password,
                        updated_by: payload.email
                    }
                    let updatepass = await userservice.Update(params,payloadata)
                    if (updatepass == 1) {
                      // based roles need to handel need permission
                      let scopes= await  permissionService.scopermission(fetch[0])
                      fetch[0].scope = scopes;
                      let token = await tokenService.TokenGenarate(fetch[0],true);
                      let output = {
                        statusCode: 200,
                        message: "Activated success",
                        data: { token },
                      };
                      return output;
                    } else {
                      return Boom.badRequest("No User Found");
                    }
                  }else {
                    return Boom.unauthorized(TokenValidation.error)
                }

                }else if(payload.password && payload.id){
                    let token
                    if(request.headers.authorization !== undefined){
                        let EncodeToken = request.headers.authorization.split(" ")[1]
                        token = await tokenService.TokenValidation(EncodeToken)
                    }
                    if (token.isValid) {
                        let params =  {
                            id : payload.id,
                            account_id:token.payload.account_id,

                        }
                        let payloadata ={
                            auth:'Y',
                            password: payload.password,
                            updated_by: token.payload.email
                        }
                        let updatepass = await userservice.Update(params,payloadata)
                        if (updatepass == 1) {
                          let output = {
                            statusCode: 200,
                            message: "Reset Password Success"
                          };
                          return output;
                        } else {
                          return Boom.badRequest("No User Found");
                        }
                    } else {
                      return Boom.unauthorized(TokenValidation.error);
                    }

                }
            }else {
                return Boom.badRequest('Invalid data Not Found');
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