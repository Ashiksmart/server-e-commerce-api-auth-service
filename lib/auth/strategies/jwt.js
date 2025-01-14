'use strict';


module.exports = (server, options) => ({

    scheme: 'jwt',
    options: {
        keys: {
            key: options.jwtKey,
            algorithms: ['HS256']
        },
        verify: {
            aud: false,
            iss: false,
            sub: false
        },
        validate: async (decoded, request) => {
            try {
                if (decoded) {
                    return decoded.decoded.payload.scope
                        ? {
                            isValid: true,
                            credentials: {
                                scope: decoded.decoded.payload.scope.split(',')
                            }
                        }
                        : { isValid: true };
                }
                return { isValid: false };
            } catch (error) {
                console.log(error)
                return { isValid: false };
            }

        }
    }
});