#!/bin/bash

# --- VARIABLE CONFIGS ---
CONFIG_FILE="$HOME/.aws/credentials"
EMAIL='{email}'
PROFILE='{profile}'
IAM_NUMBER='{iam_number}'

echo '=> Typing a MFA code:'
read MFA_CODE

# --- RUN AWS COMMAND ---
echo ' '
echo '=> Getting Session Token...'
RESULT=`aws sts get-session-token --serial-number arn:aws:iam::$IAM_NUMBER:mfa/$EMAIL --token-code $MFA_CODE --profile $PROFILE`

# --- GET RESULT VARIABLES ---
ACCESS_KEY=`jq -r '.Credentials.AccessKeyId' <<< "$RESULT"`
SECRET_ACCESS_KEY=`jq -r '.Credentials.SecretAccessKey' <<< "$RESULT"`
SESSION_TOKEN=`jq -r '.Credentials.SessionToken' <<< "$RESULT"`

# --- SET ON CONFIG FILE ---
sed -i "5,8 s/\(aws_access_key_id *= *\).*/\1$ACCESS_KEY/" $CONFIG_FILE
sed -i "5,8 s#\(aws_secret_access_key *= *\).*#\1$SECRET_ACCESS_KEY#" $CONFIG_FILE
sed -i "5,8 s#\(aws_session_token *= *\).*#\1$SESSION_TOKEN#" $CONFIG_FILE

echo ' '
echo '---------------------------'
echo "NEW: $CONFIG_FILE"
echo ' '
