import * as cdk from '@aws-cdk/core';
import * as lambda from '@aws-cdk/aws-lambda';

export class CdkStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    const exceptionTestFunction =
      new lambda.Function(this, 'ExceptionTestFunction', {
        runtime: lambda.Runtime.PROVIDED_AL2,
        code: lambda.Code.fromAsset('../runtime/result'),
        handler: 'UNUSED'
      });
  }
}
