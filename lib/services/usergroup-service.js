"use strict";

const Schmervice = require("@hapipal/schmervice");
const Boom = require("@hapi/boom");

module.exports = class UserGroupService extends Schmervice.Service {
  async create(payload,token) {
    try {
      payload.created_by = token.payload.email;
      payload.updated_by = token.payload.email;
      payload.account_id = token.payload.account_id;
      payload.active = "Y";

      let { UserGroup } = this.server.models();
      let create = await UserGroup.query().insert(payload);
      if (create) {
        let output = {
          statusCode: 201,
          message: "success",
          data: create,
        };
        return output;
      } else {
        return Boom.badRequest();
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
        let { UserGroup } = this.server.models();
      let page = 0;
      let limit = 10;
      let condition = {};
      let direction = "desc";
      if (query.name != undefined && query.name != "" && query.name) {
        condition["name"] = query.name;
      }
      if (query.active != undefined && query.active != "" && query.active) {
        condition["active"] = query.active;
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
      if (query.id != undefined && query.id != "" && query.id) {
        condition.id = query.id;
      }
      if (query.partner_id != undefined && query.partner_id != "" && query.partner_id) {
        condition.partner_id = query.partner_id;
      }
      condition.account_id = token.payload.account_id;
      let fetch = await UserGroup.query()
        .where(condition)
        .select("*")
        .offset(page)
        .limit(limit)
        .orderBy("id", direction);
      let count = await UserGroup.query().where(condition).count("id as count");
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
        let { UserGroup } = this.server.models();
        let payload = JSON.parse(JSON.stringify(payloadData))
      payload.account_id =  token.payload.account_id
      payload.updated_by = token.payload.email
      let update = await UserGroup.query().where(params).update(payload)
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
      let { UserGroup } = this.server.models();
   let payload ={}
   payload.account_id =  token.payload.account_id
   payload.updated_by = token.payload.email
   payload.active = "N";
   let update = await UserGroup.query().where(params).update(payload)
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
