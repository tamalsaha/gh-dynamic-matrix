#!/bin/bash

k8s=(v1.12.10, v1.14.10, v1.16.9, v1.18.4)
db=(7.3.2, 7.2.0, 6.8.0, 6.5.3, 6.4.0, 6.3.0-v1, 6.2.4-v1, 5.6.4-v1)

# jo -p k8s=$(jo -p -a ${k8s[@]}) db=$(jo -p -a ${db[@]})

# abc=$(echo $(jo include=$(jo k8s=$(jo -a ${k8s[@]}) db=$(jo -a ${db[@]}))))
# echo $abc


# xyz=$(jo include=$(jo k8s=$(jo -a ${k8s[@]}) db=$(jo -a ${db[@]})) | tr " \")
# echo $xyz


jo include=$(jo k8s=$(jo -a ${k8s[@]}) db=$(jo -a ${db[@]})) | sed -r 's/"/\\"/g'

# # echo -n "$TEST_CREDENTIALS" > hack/config/.env
# # echo >> hack/config/.env
# # echo "GOOGLE_SERVICE_ACCOUNT_JSON_KEY=$(echo $GOOGLE_SERVICE_ACCOUNT_JSON_KEY)" >> hack/config/.env


# echo "xyz=$(echo $xyz)" >> .env
