# Tanker - K8S Applications POC builder

Tanker is a small project with the purpose of running in a local kubernetes cluster provided by [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/#quickstart) to test your dockerized applications without suffering to configuring or setting up your environment.  

The idea behind it is: place your k8s *yamls into `k8s-apps/${YOUR-APP}/` and be happy! :D  

## Before you begin

Make sure that your machine follows the requisites:

- A *nix system running an apt-compatible OS, e.g. Ubuntu or Debian
- 3 GB or more of RAM (it needs to handle the virtualization as well)
- 2 CPUs or more

Ensure that you have `docker` both client and version `1.13.x` or superior  

## Getting Started

To run the app, just:  

`./tanker`  

It will run a kubernetes cluster under kvm driver and exposes the URL to be tested locally from a demonstration Wordpress application.  

The first execution can take some time due to the virtual machine creation.  

## Security

It's highly recommended that **you do not** use tanker in production environments. The purpose of this project is to setup a development environment the quickest way. After that the deployment of your POC must be done with a secure Kubernetes Cluster using one of the following tools: `kops` or `kubeadm`  

## Troubleshooting  

In order to run the app and follow line by line what happened, just set the environment variable `DEBUG` located at `config/environment.sh` as true. The next `./tanker` will output what is going on *under the hood*  

To wipe every minikube data due any additional problems when creating/running the cluster you can:

```
$ minikube stop # if started
$ minikube delete
$ rm -rf ~/.minikube
```

Then you can ask `./tanker` to create it again

## Why not kubeadm?

You must be wondering why the project just not use `kubeadm` to install a real cluster instead of a virtual one using `minikube`. The `kubeadm` may need some additional intrusive configuration such as kernel configurations and network changes which could break any other part of the system if used in a dev machine instead of a server. To keep it simple, the `minikube` handles the situation. 