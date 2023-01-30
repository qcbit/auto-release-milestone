#!/bin/bash

# Warn if undeclared variable is used
set -u 

echo "release-url::http://example.com" >> $GITHUB_OUTPUT

exit 0