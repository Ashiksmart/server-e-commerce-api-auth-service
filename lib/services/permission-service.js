"use strict";

const Schmervice = require("@hapipal/schmervice");
const Boom = require("@hapi/boom");

module.exports = class PermissionService extends Schmervice.Service {
  async fetch(token) {
    try {
      let { Permission } = this.server.models();
      let condition = { active: "Y", account_id: token.payload.account_id , default:"N"};
      let direction = "desc";

      let fetch = await Permission.query()
        .where(condition)
        .select("*")
        .orderBy("id", direction);
      let count = await Permission.query()
        .where(condition)
        .count("id as count");
      if (fetch.length > 0) {
        let output = {
          statusCode: 200,
          message: "success",
          count: count[0].count,
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
      console.log(error);
      if (error.nativeError.sqlState == "23000") {
        return Boom.conflict();
      } else {
        const err = Boom.badRequest(
          error.name ? `${error.name}:${error.type}` : error.message
        );
        return err;
      }
    }
  }

  async scopermission(data){
    try {
      let { Permission, UserGroup } = this.server.models();
      let {account_id , roles , user_group , partner_id }=data
      let permission = ""
      // let condition = {account_id,active: "Y",default:"Y"}
      // if(roles == "Superadmin" || roles == "SubSuperadmin"){
        // delete condition.default
      // }
      let condition = {account_id,active: "Y"}
      let fetch = await Permission.query().where(condition)
      // delete condition.default
      if(fetch.length>0){
       let scopeval =  fetch.map((elm)=>{
        return elm.permission.map((e)=>{
          return e.value 
         })
        })
        permission = scopeval.flat().join(',')
      }
      
      
      // if( roles == "Admin" || roles == "SubAdmin" || roles == "Employee" || roles == "Client" ){
      //   condition.id = user_group
      //   condition.partner_id = partner_id
      //   let fetch = await UserGroup.query().where(condition).limit(1)
      //   if(fetch.length > 0){
      //     let scopeval = fetch[0].permission_values.map((e) => {
      //       return e.params.map((elm) => {
      //         return elm;
      //       });
      //     });
      //     permission += ","+scopeval.flat().join(',')
      //   }
      // }
      return permission

  } catch (error) {
    console.log(error);
      const err = Boom.badRequest(
        error.name ? `${error.name}:${error.type}` : error.message
      );
      return err;
  }
  }
};
