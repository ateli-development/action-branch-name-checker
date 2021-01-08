#!/bin/bash


GIT_MESSAGES=$(git log master.. --no-merges --first-parent --pretty=format:%H%s | grep -oP "^.{40}.{8}")


for message in $GIT_MESSAGES
do
  COMMIT_REVISION_NUMBER=$(echo $message | cut -c 1-40)
  COMMIT_MESSAGE_PREFIX=$(echo $message | cut -c 41-48)
  VALID_COMMIT_MESSAGE_PREFIX=$(git rev-parse --abbrev-ref HEAD | grep -oP "PZ-\d{4}"):


  if [[ $VALID_COMMIT_MESSAGE_PREFIX != $COMMIT_MESSAGE_PREFIX ]]
  then
    printf "commit message with revision $COMMIT_REVISION_NUMBER should be started with: $VALID_COMMIT_MESSAGE_PREFIX , but it is started with $COMMIT_MESSAGE_PREFIX\n"
    printf "How you can edit your commit messages?: https://"
    exit 101
  fi
done