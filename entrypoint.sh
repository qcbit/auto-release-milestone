#!/bin/bash

# Warn if undeclared variable is used
set -u 

repo_token=$1

if [ "$GITHUB_EVENT_NAME" != "milestone" ]; then
    echo "::debug::The event name was '$GITHUB_EVENT_NAME'"
    exit 0
fi

event_type=$(jq --raw-output .action $GITHUB_EVENT_PATH)

if [ $event_type != "close" ]; then
    echo "::debug::The event type was '$event_type'"
    exit 0
fi

milestone_name=$(jq --raw-output .milestone.title $GITHUB_EVENT_PATH)

IFS='/' read owner repository <<< "$GITHUB_REPOSITORY"

release_url=$(dotnet gitreleasemanager create \
--milestone $milestone_name \
--targetcommitish $GITHUB_SHA \
--token $repo_token \
--owner $owner \
--repository $repository)

if [ $? -ne q ]; then
    echo "::error::Failed to create the release draft"
    exit 1
fi

echo "release-url=$release_url" >> $GITHUB_OUTPUT

exit 0