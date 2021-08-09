#!/bin/bash

baseURL="$baseURL/$ACCOUNT_ID"
authToken="$AUTH_TOKEN"
WORKSPACE="$pwd"
env

source bin/dynamicScriptGitJobBuilder.sh commit_id="$GITHUB_SHA" env="$ENV" conf_folder="$CONF_FOLDER"