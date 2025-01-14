"use strict";

const Schmervice = require("@hapipal/schmervice");
const Boom = require("@hapi/boom");
const Jwt = require("@hapi/jwt");
const Tokenspan = process.env.TOKEN_SPAN;
const APP_SECRET = process.env.APP_SECRET;
module.exports = class TokenService extends Schmervice.Service {
  async TokenGenarate(payload,is_spantime,Tknspan) {
    try {
      if(is_spantime && Tknspan == undefined){
        Tknspan=Number(Tokenspan)
      }
      let v_token = Jwt.token.generate(
        payload,
        {
          key: APP_SECRET,
          algorithm: "HS256",
        },
        {
          ttlSec: Tknspan,
        }
      );
      return v_token;
    } catch (error) {
      console.log(error);
      const err = Boom.badRequest(
        error.name ? `${error.name}:${error.type}` : error.message
      );
      return err;
    }
  }

  async TokenValidation(token) {
    try {
      const decodedToken = Jwt.token.decode(token);
      const verifyToken = (artifact, secret, options = {}) => {
        try {
          Jwt.token.verify(artifact, secret, options);
          return { isValid: true, payload: artifact.decoded.payload };
        } catch (err) {
          console.log(err);
          return {
            isValid: false,
            error: err.message,
          };
        }
      };
      return verifyToken(decodedToken, APP_SECRET);
    } catch (error) {
      console.log(error);
      const err = Boom.badRequest(
        error.name ? `${error.name}:${error.type}` : error.message
      );
      return err;
    }
  }
};
