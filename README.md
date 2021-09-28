# Haskell Lambda Runtime Exception Test

This project implements an AWS Lambda Function that echoes a message
that it receives on its input, and then throws it as an
exception. `hal` [reports this to the Lambda Runtime
API](https://github.com/Nike-Inc/hal/blob/fc5318d57bf7bcee1b552b6e0e7ab0e71abeab4a/src/AWS/Lambda/Runtime/Value.hs#L76); where does it go?

## Deploying to AWS

### Building the Lambda Function

The `runtime/` directory contains a small cabal package that
implements the Lambda Function. Because of LGPL restrictions on
`integer-simple` (used by the Haskell RTS), no binary is
provided. Build instructions follow:

You will need [Nix](https://nixos.org/download.html) installed and
able to build derivations on `x86_64-linux` machines. This is
trivially satisfied if you are on a GNU/Linux machine (use an EC2
instance), or macOS users can set up [LnL7's Docker container as a
remote
builder](https://github.com/LnL7/nix-docker#running-as-a-remote-builder).

Ensure that you have the IOHK Nix cache installed, otherwise you will
build many copies of GHC. You want these lines in your `nix.conf` file:

```
substituters = https://cache.nixos.org https://hydra.iohk.io
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=
```

Then, build the Lambda binary:

```shell
cd runtime
nix build -f .
```

This will download and build a bunch of stuff, ultimately creating a
`result` symlink pointing at a directory in the Nix Store containing a
`bootstrap` executable.

### Deploying the Lambda Function

The `cdk` directory defines a CDK app that provisions the above Lambda
Function. If you have `npm` installed, you can deploy (after building
the binary) by running:

```shell
cd cdk
npm install
npm run cdk deploy
```
