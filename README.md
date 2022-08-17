# aws-mfa
Get session token in aws cli using MFA. 

## Requirements

Install libraries below:

* [jq](https://stedolan.github.io/jq/)

## Configuration

### 1. Create aws credentials

When running the command below, it will create a file **~/.aws/credentials**.
```bash
$ aws configure
```

### 2. Set config variables on script

```bash
CONFIG_FILE="$HOME/.aws/credentials"
EMAIL='{email}'
PROFILE='{profile}' # prevdefault
IAM_NUMBER='{iam_number}'
```

### 3. Run the script

```bash
$ sudo chmod +x ./aws-mfa.sh
$ ./aws-mfa.sh
```