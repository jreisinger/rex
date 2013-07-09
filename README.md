## Rex

http://rexify.org/

## Usage

Installation

1. [get rex](http://rexify.org/get/index.html)
1. clone this repo and change to it, ex.: `git clone https://github.com/jreisinger/rex.git && cd rex`

Amazon stuff

1. Register at http://aws.amazon.com/
1. Get your AccessKey and your Secret AccessKey
1. create config file:

        touch .pass.yml
        chmod 600 .pass.yml

1. edit `.pass.yml`:

        # EC2 security credentials
        auth:
            access_key: <AWSAccessKeyId>
            password: <AWSSecretKey>

        # cloud info
        cloud:
            region: "ec2.eu-west-1.amazonaws.com"

1. create key pair called `rex` in Amazon portal and store it as (to create a public key out of your just downloaded private key: `ssh-keygen -y -f your-aws-private-key.pem`):

        .priv-key.pem
        .pub-key.key

1. secure the private key

        chmod 600 .priv-key.pem

Run tasks

1. list tasks: `rex -T`
1. run your task: `rex <task>`, ex.:

        rex amazon:dump-cloud-info
        rex amazon:list
        rex amazon:create --name=vm01
        rex -H <ip-address> sw:apache
        rex amazon:destroy --name=vm01
