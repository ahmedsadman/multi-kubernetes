# multi-kubernetes
An intentionally complex fibonacci calculator requiring multiple services, deployed through DigitalOcean Kubernetes


## Configuring DigitalOcean

### Switching Kubernetes Context
We can easily switch config context and directly interact with the DO cluster using `kubectl` commands. [Follow this guide](https://docs.digitalocean.com/products/kubernetes/how-to/connect-to-cluster)

In short, need to run the series of commands
```
doctl kubernetes cluster kubeconfig save use_your_cluster_name // save cluster config locally
kubectl config get-contexts // see all contexts, the new DO context should be available
kubectl use-context <context_name> // for switching contexts back and forth
```
