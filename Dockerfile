# Container image that runs your code
FROM mcr.microsoft.com/dotnet/core/sdk:3.1

LABEL "com.github.actions.name"="Auto Release Milestone"
LABEL "com.github.actions.description"="Drafts a GitHub release based on a newly closed milestone"

LABEL version="0.1.0"
LABEL repository="https://github.com/qcbit/auto-release-milestone"
LABEL maintainer="Lance Truong"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
