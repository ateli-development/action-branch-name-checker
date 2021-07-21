#!/bin/bash

echo "Branch name: ${BRANCH_NAME}"
echo "Pull request title: ${PULL_REQUEST_TITLE}"
echo "**********************************************"

IS_RELEASE_BRANCH=$( echo ${BRANCH_NAME} | grep -P "^(release|revert).*/" | wc -l)



if [[ $IS_RELEASE_BRANCH != "1" ]]
then
  IS_BRANCH_NAME_VALID=$( echo ${BRANCH_NAME} | grep -P "^(bug|feature|hotfix|epic)/PZ-\d+" | wc -l)
else
  IS_BRANCH_NAME_VALID=$( echo ${BRANCH_NAME} | grep -P "^(release|revert).+" | wc -l)
fi


if [[ $IS_BRANCH_NAME_VALID == "1" && $IS_RELEASE_BRANCH == "1" ]]
then
  echo "It not check the PR name of release and revert branches "
  exit 0
fi




VALID_COMMIT_MESSAGE_PREFIX=$(echo ${BRANCH_NAME} | grep -oP "PZ-\d+")
IS_PULL_REQUEST_TITLE_VALID=$(echo $PULL_REQUEST_TITLE | grep -P "^"$VALID_COMMIT_MESSAGE_PREFIX".+" | wc -l)


if [[ $IS_BRANCH_NAME_VALID != "1" ]]
then
  echo "The branch name( $BRANCH_NAME ) is not valid, for more information visit: https://github.com/ateli-development/shipgratis/wiki/Coding-standards"
  exit 101
fi





if [[ $IS_PULL_REQUEST_TITLE_VALID != "1" ]]
then
  echo "The pull request title( $PULL_REQUEST_TITLE ) is not valid, it should be in this format: ${VALID_COMMIT_MESSAGE_PREFIX} here is the jira title"
  exit 101
fi

