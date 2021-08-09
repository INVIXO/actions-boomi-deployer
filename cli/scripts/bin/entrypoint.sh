#!/bin/bash

export baseURL="$baseURL/$ACCOUNT_ID"
export WORKSPACE="$GITHUB_WORKSPACE"
env

source bin/dynamicScriptGitJobBuilder.sh commit_id="$GITHUB_SHA" env="$ENV" conf_folder="$CONF_FOLDER"