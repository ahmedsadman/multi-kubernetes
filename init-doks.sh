#!/bin/sh

## ------> MAKE SURE TO RUN "doctl auth init" BEFORE EXECUTING THIS SCRIPT <------
## --
## This script is used to initialize the DigitalOcean Kubernetes Cluster and deploy the application
## --

## Usage
## > ./init_doks.sh <cluster_name>

# check DOCTL command
if ! [ -x "$(command -v doctl)" ];
then
    echo "Error: DOCTL is not installed"
    exit 1
fi

# create kubectl config context
doctl kubernetes cluster kubeconfig save $1 # $1 -> cluster name/identifier
echo "Created kubernetes config and switched context"

# create DB secret
kubectl create secret generic pgpassword --from-literal PGPASSWORD=1234asdf # change password
echo "DB secret created"

# install helm
if ! [ -x "$(command -v helm)" ];
then
    echo "Installing Helm"
    APP_DIR=$(pwd)
    install helm
    cd /tmp
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
    chmod u+x get_helm.sh
    ./get_helm.sh
    cd $APP_DIR
fi


# add kubernetes nginx-ingress controller
echo "Configuring ingress-nginx"
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install my-release ingress-nginx/ingress-nginx
echo "Configured\n"

echo "Backoff time for ingress-nginx to complete creation (approx 3 mins)"
sleep 180


# apply config
echo "Applying kubernetes deployments"
kubectl apply -f k8s
echo "Complete\n"

echo "\nWARNING: Your kubeconfig context is now switched to your DOKS cluster"
exit 0
