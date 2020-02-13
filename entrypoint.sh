#!/bin/sh -l

echo "Hello $1"
printenv
printenv WHAT_TO_SAY
time=$(date)
echo ::set-output name=time::$time