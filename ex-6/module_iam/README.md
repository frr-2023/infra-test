# IAM Resources

Creation of the different resources required in the practice. 
- Multiple users creation.
- Users have to be members of the group
- The role should have a policy attached that allows the users to assume a independent role
- Create a role allowing the users from the account to assume it.

Note: The exercise required to pass the users list for the creation of the resources, but for having
a common name between the other resources we pass a map.
Ex:
```hcl-terraform
users = {
    group = {
      name = "infra-test-developers"
    }
    users = ["user1", "user2", "user3"]
  }
```

You can check with aws cli the assume of the role:

```shell script
aws configure --profile infra-test-module                                         
AWS Access Key ID [None]: DELETED
AWS Secret Access Key [None]: DELETED
Default region name [None]: eu-west-1
Default output format [None]: 

aws sts assume-role --role-arn  arn:aws:iam::795328594153:role/system/infra-test-developers-role --role-session-name infra-test-role
{
    "Credentials": {
        "AccessKeyId": "DELETED",
        "SecretAccessKey": "DELETED",
        "SessionToken": "DELETED",
        "Expiration": "2023-10-06T18:51:38+00:00"
    },
    "AssumedRoleUser": {
        "AssumedRoleId": "AROA3SLKHIDU5HUDVHOMS:infra-test-role",
        "Arn": "arn:aws:sts::000000000000:assumed-role/infra-test-developers-role/infra-test-role"
    }
}

```

The terraform in
