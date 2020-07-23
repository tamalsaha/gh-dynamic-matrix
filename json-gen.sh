#!/bin/bash

k8s=(v1.12.10 v1.14.10 v1.16.9 v1.18.4)
db=(7.3.2 7.2.0 6.8.0 6.5.3 6.4.0 6.3.0-v1 6.2.4-v1 5.6.4-v1)

# jo -p k8s=$(jo -p -a ${k8s[@]}) db=$(jo -p -a ${db[@]})

# abc=$(echo $(jo include=$(jo k8s=$(jo -a ${k8s[@]}) db=$(jo -a ${db[@]}))))
# echo $abc


# xyz=$(jo include=$(jo k8s=$(jo -a ${k8s[@]}) db=$(jo -a ${db[@]})) | tr " \")
# echo $xyz

# jo include=$(jo k8s=$(jo -a ${k8s[@]}) db=$(jo -a ${db[@]})) | sed -r 's/"/\\"/g'

# jo include=$(jo k8s=$(jo -a ${k8s[@]}) db=$(jo -a ${db[@]})) | yq r --prettyPrint -

# # echo -n "$TEST_CREDENTIALS" > hack/config/.env
# # echo >> hack/config/.env
# # echo "GOOGLE_SERVICE_ACCOUNT_JSON_KEY=$(echo $GOOGLE_SERVICE_ACCOUNT_JSON_KEY)" >> hack/config/.env


# echo "xyz=$(echo $xyz)" >> .env

# https://zaiste.net/posts/how-to-join-elements-of-array-bash/
function join { local IFS="$1"; shift; echo "$*"; }

matrix=()
for x in ${k8s[@]}; do
    for y in ${db[@]}; do
        echo $( jq -n -c --arg x "$x" --arg y "$y" '{"k8s":$x,"db":$y}' )
        matrix+=( $( jq -n -c --arg x "$x" --arg y "$y" '{"k8s":$x,"db":$y}' ) )
        # matrix+=( $(jo k8s=$x db=$y) )
    done
done











# (join , ${matrix[@]}) | sed -r 's/"/\\"/g'

# data=$((join , ${matrix[@]}) | sed -r 's/"/\\"/g')

# function join { local IFS="$1"; shift; echo "$*"; }

# out=()
# for x in ${k8s[@]}; do
#     for y in ${db[@]}; do
#         out+=( $(jo k8s=$x db=$y) )
#     done
# done
# join , ${out[@]}

# echo "k8s:" ${k8s[@]}
# echo "db:" ${db[@]}
# matrix=$(jo include=$(jo k8s=$(jo -a ${k8s[@]}) db=$(jo -a ${db[@]})) | sed -r 's/"/\\"/g')


# matrix=$(echo "{\"include\":[$(join , ${matrix[@]})]}" | sed -r 's/"/\\"/g')

# IFS=","
# matrix=$(echo "{"include":[$(echo "${matrix[@]}")]}")

matrix=$(echo "{\"include\":[$(join , ${matrix[@]})]}")
echo $matrix


BUCKET_NAME=9.3
OBJECT_NAME=testworkflow-2.0.1.jar
TARGET_LOCATION=/opt/test/testworkflow-2.0.1.jar

JSON_STRING=$( jq -n \
                  --arg bn "$BUCKET_NAME" \
                  --arg on "$OBJECT_NAME" \
                  --arg tl "$TARGET_LOCATION" \
                  '{bucketname: $bn, objectname: $on, targetlocation: $tl}' )

echo $JSON_STRING