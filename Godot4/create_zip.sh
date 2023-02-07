#!/bin/bash

cd $(dirname $0)

if [ $# -eq 0 ]; then
  echo "Need subfolder name as first argument."
  exit 1
fi

rm -f "$1.zip"
git ls-files -- "$1" | zip -@ "$1.zip"
