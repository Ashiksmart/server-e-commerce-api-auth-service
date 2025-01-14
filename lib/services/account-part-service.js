"use strict";

const Schmervice = require("@hapipal/schmervice");
const Boom = require("@hapi/boom");
let { v4: uuidv4 } = require("uuid");

module.exports = class AccountPartService extends Schmervice.Service {
  async create(payload,token) {
    try {
      let { ProjectPartnerAccount } = this.server.models();
      const { accountservice, userservice } = this.server.services();
      payload.account_id = token ? token.payload.account_id : payload.account_id;
      payload.partner_id = uuidv4();
      payload.created_by = payload.email;
      payload.updated_by = payload.email;
      payload.active = "Y";
      payload.account_license = "N"
      payload.account_req = token && token.payload.roles != "Client" ? 'N' : 'Y'
      let create = await ProjectPartnerAccount.query().insert(payload);

      if (create) {
        let userdata = {
          account_id: create.account_id,
          partner_id: create.partner_id,
          first_name: `${create.username}_admin`,
          email: create.email,
          password: await accountservice.passwordFormate(create.username),
          roles: "SubSuperadmin",
          auth: "N",
          user_group:null,
          active: "Y",
          created_by: create.email,
          updated_by: create.email,

        };
        let admincreate = await userservice.CreateUser(userdata);
        if (admincreate.statusCode == 201) {
          create["user"] = { ...userdata , id:admincreate.data.id};
          let output = {
            statusCode: 201,
            message: "success",
            data: create,
          };
          return output;
        }
      } else {
        return Boom.badRequest("bad request");
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
  async fetch(query,token) {
    try {
      let { ProjectPartnerAccount } = this.server.models();
      let page = 0
      let limit = 10
      let condition = {}
      let direction = 'desc'
      if (query.limit != undefined && query.limit != "" && query.limit) {
        limit = query.limit;
      }

      if (query.page != undefined && query.page != "" && query.page) {
        page = limit*(query.page-1);
      }

      if (query.name != undefined && query.name != "" && query.name) {
        condition["name"] = query.name;
      }

      if (query.active != undefined && query.active != "" && query.active) {
        condition["active"] = query.active;
      }

      if (query.direction != undefined && query.direction != "" && query.direction) {
        direction = query.direction;
      }

      if(token.payload.role == "SubSuperAdmin"){
        condition.partner_id = token.payload.partner_id
      }

      if(query.id!= undefined && query.id != "" && query.id){
        condition.id = query.id
      }
      if(query.partner_id!= undefined && query.partner_id != "" && query.partner_id){
        condition.partner_id = query.partner_id
      }

      condition.account_id = token.payload.account_id


      let fetch = await ProjectPartnerAccount.query().where(condition).select('*').offset(page).limit(limit).orderBy('id', direction)
      let count = await ProjectPartnerAccount.query().where(condition).count('id as count')
      if (fetch.length>0) {
          let output = {
              statusCode: 200,
              message: "success",
              count:count[0].count,
              page:page,
              limit:limit,
              direction,
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
  async update(params, payloadData,token) {
    try {
      params.account_id = token.payload.account_id;
      let payload = JSON.parse(JSON.stringify(payloadData))
      payload.updated_by = token.payload.email;
      let { ProjectPartnerAccount } = this.server.models();
      let update = await ProjectPartnerAccount.query()
        .where(params)
        .update(payload);
      if (update) {
        let output = {
          statusCode: 200,
          message: "success",
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

  async delete(params,token) {
    try {
      let { ProjectPartnerAccount } = this.server.models();
      let {  userservice} = this.server.services();

      let payload ={}
      payload.updated_by = token.payload.email;
      payload.account_id = token.payload.account_id
      payload.active = "N";
      let update = await ProjectPartnerAccount.query()
        .where(params)
        .update(payload);
      if (update) {
        let fetchpartnerinfo = await this.fetch(params,token)
        if(fetchpartnerinfo.count == 1){
          let params =  {
            account_id:token.payload.account_id,
            partner_id:fetchpartnerinfo.data[0].partner_id
          }
          let payloadata ={
            active : "N",
            updated_by: token.payload.email
          }
          let updatepass = await userservice.Update(params,payloadata)
        }
        let output = {
          statusCode: 200,
          message: "success",
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
};
