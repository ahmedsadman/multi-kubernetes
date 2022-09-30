# multi-kubernetes
An intentionally complex fibonacci calculator requiring multiple services, deployed through DigitalOcean Kubernetes


## Configuring DigitalOcean

### Cluster init script
You can use the `init-doks.sh` file to initialize your DOKS (DigitalOcean Kubernetes) cluster and deploy the application. You need to
run the series of following commands when cluster provisioning is complete

```
chmod +x init-doks.sh # give execute permission
doctl auth init # authorize DO access with access token
./init-doks.sh <doks_cluster_id>
```

The script will setup everything. Please note, a CI/CD pipeline is also created with Github Actions. But to make the CI/CD
pipeline work properly, either you have to run this `init-doks.sh` file or configure the cluster manually (first-time only).

### Switching Kubernetes Context
We can easily switch config context and directly interact with the DO cluster using `kubectl` commands. [Follow this guide](https://docs.digitalocean.com/products/kubernetes/how-to/connect-to-cluster)

In short, need to run the series of commands
```
doctl kubernetes cluster kubeconfig save use_your_cluster_name // save cluster config locally
kubectl config get-contexts // see all contexts, the new DO context should be available
kubectl use-context <context_name> // for switching contexts back and forth
```

Alternatively, at the time of writing this, DO Kubernetes also shows a getting started guide after creating a DOKS cluster, where you 
can find the necessary set of commands to set and switch contexts (Recommended approach)


### Creating Secret
At this point, your kubernetes config should be switched and you can run any `kubectl` command in your DOKS cluster. To create a secret for Postgres password:
```
kubectl create secret generic pgpassword --from-literal PGPASSWORD=1234asdf
```

### CI/CD Pipeline
A simple CI/CD pipeline has been created with Github Actions. You can check the Deploy workflow for more details