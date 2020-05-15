#!/bin/bash

cd $(dirname $0)

find . \
  -maxdepth 1 \
  -type d \
  -not -path '*/\.*' \
  -not -path '.' \
  -exec sh -c 'zip -r "$0.zip" $0' {} \;
