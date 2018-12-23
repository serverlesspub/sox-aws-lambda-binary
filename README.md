# SoX for AWS Lambda

Run Sound eXchange (SoX), the Swiss Army knife of audio manipulation, with Lame on AWS Lambda.

This is a static binary of [sox](http://sox.sourceforge.net) utility, built for AWS Lambda, deployable as an AWS lambda layer. It can help you get started quickly with RSVG inside Lambda functions. It supports `sox`, `soxi` and `lame` commands.

## Use within Lambda

You can use a pre-deployed ARN: `arn:aws:lambda:us-east-1:145266761615:layer:sox:1` or deploy yourself -- edit Makefile to set your deployment bucket etc, then just run `make deploy`.

The binaries will be in `/opt/bin/` inside your Lambda container.

Alternatively, grab the binaries from the [vendor](/vendor) directory and package to Lambda yourself.

## License

GNU GENERAL PUBLIC LICENSE, Version 2.



