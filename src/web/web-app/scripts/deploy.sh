#!/usr/bin/env bash
set -eux
source ./env/app.env
source ./env/build_vars.env

kubectl="kubectl -v4 --insecure-skip-tls-verify=true --namespace=${NAMESPACE}"

function conf {
    cat kubernetes/*.yml > kubernetes/apply.yml
    envsubst < kubernetes/apply.yml &&\
    rm -f kubernetes/apply.yml
}

for context in "${CONTEXTS[@]}"; do

    if ! [[ $(kubectl get namespace ${NAMESPACE} --ignore-not-found=true) ]]; then
        kubectl --context=${context} create namespace ${NAMESPACE}
    else
        ${kubectl} --context=${context} delete deployment ${DEPLOYMENT}
        ${kubectl} --context=${context} delete svc ${DEPLOYMENT}
    fi

    conf | ${kubectl} --context=${context} apply -f -
    sleep 5
	${kubectl} --context=${context} rollout status deployment/${DEPLOYMENT}

done
