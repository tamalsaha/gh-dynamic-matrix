#!/bin/bash

set -eou pipefail

# /ok-to-test [refs/master]
# /ok-to-test [refs/master] v1.18.4 7.3.2
# /ok-to-test [refs/master] v1.18.4
# /ok-to-test [refs/master] * 7.3.2 # * means all default k8s versions

k8s=(v1.12.10 v1.14.10 v1.16.9 v1.18.4)
db=(4.1.13-v1 4.1.7-v3 4.1.4-v1 4.0.11-v1 4.0.5-v3 4.0.3-v1 3.6.13-v1 3.6.8-v1 3.4.22-v1 3.4.17-v1)

IFS=' '
read -ra COMMENT <<< "/ok-to-test refs/mg"

start=0
prefix=refs/
if [[ ${COMMENT[1]} == ${prefix}* ]]; then
  echo "::set-output name=e2e_ref::${COMMENT[1]#$prefix}"
  start=1
else
  echo "::set-output name=e2e_ref::master"
fi

echo ${COMMENT[((start+1))]}
echo ${COMMENT[$((start+2))]}

if [ ! -z ${COMMENT[$((start+1))]} ] && [ ${COMMENT[$((start+1))]} != "*" ]; then
  k8s=(${COMMENT[$((start+1))]})
fi
if [ ! -z ${COMMENT[$((start+2))]} ]; then
  db=(${COMMENT[$((start+2))]})
fi

matrix=()
for x in ${k8s[@]}; do
    for y in ${db[@]}; do
        matrix+=( $( jq -n -c --arg x "$x" --arg y "$y" '{"k8s":$x,"db":$y}' ) )
    done
done

# https://stackoverflow.com/a/63046305/244009
function join { local IFS="$1"; shift; echo "$*"; }
matrix=$(echo "{"include":[$(join , ${matrix[@]})]}")
echo $matrix
echo "::set-output name=matrix::$matrix"
