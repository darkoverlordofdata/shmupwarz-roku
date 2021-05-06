#!/usr/bin/env bash

rm -fv ./shmupwarz-roku.zip
zip -r shmupwarz-roku.zip . \
    --exclude build.sh \
    --exclude run.sh \
    --exclude *.gitignore \
    --exclude *.DS_Store* \
    --exclude *.vscode* \
    --exclude *.git* \
    --exclude *.pop* 
    