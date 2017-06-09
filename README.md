### api server

#### DRF login

`$ curl -H "Content-Type: application/json" -X POST http://127.0.0.1:9900/api-token-auth/ -d '{"username":"admin", "password":"password"}'`

    {"token":"4a7ca8ed5c15291dccb0bf5e64720a02fd4f0f2d"}

`$ curl -H 'Accept: application/json; indent=4' -H 'Authorization: Token 4a7ca8ed5c15291dccb0bf5e64720a02fd4f0f2d' http://127.0.0.1:9900/api/users/`

    [
        {
            "url": "http://127.0.0.1:9900/api/users/1/",
            "username": "admin",
            "email": "admin@example.com",
            "groups": []
        }
    ]

### api format

# auth
/auth/login
/auth/logout
/api/auth/token

# acount
/api/account/info
