## Rex

http://rexify.org/

## Usage

Installation

1. [get rex](http://rexify.org/get/index.html)
1. clone this repo and change to it, ex.: `git clone https://github.com/jreisinger/rex.git && cd rex`

Amazon stuff

1. create file containing Amazon security credentials

        touch .pass.yml
        chmod 600 .pass.yml
1. edit `.pass.yml`:

        auth:
            access_key: <AWSAccessKeyId>
            password: <AWSSecretKey>
1. create key pair in Amazon portal and store it as

        .priv-key.pem
        .pub-key.key
1. secure the private key

        chmod 600 .priv-key.pem

Run tasks

1. list tasks: `rex -T`
1. run your task: `rex <task>`, ex.:

        rex amazon:list
        rex amazon:create --name=vm01
        rex -H 46.137.151.9 sw:apache
