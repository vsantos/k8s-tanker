# Tanker - K8S Applications POC builder

<p align="center">
  <img width="748" height="550" src="docs/imgs/tanker.png">
</p>

Tanker is a small project with the purpose of running in a local kubernetes cluster provided by [minikube](https://kubernetes.io/docs/getting-started-guides/minikube/#quickstart) your dockerized test-applications without suffering to configuring or setting up your environment.  

The idea behind it is: place your k8s *yamls into `k8s-apps/${YOUR-APP}/` and be happy! :D  

## Tanker Diagram Overview

The following diagram makes a little more clean the interaction between internal and external clients with the application it self + k8s-cluster

<p align="center">
  <img width="726" height="301" src="docs/imgs/diagram.png">
</p>

## Before you begin

Make sure that your machine follows the requisites:

- Linux Mint 18.3 - Sylvia (100% working scenario for a fresh installation)
- 4 GB or more of **free** RAM (it needs to handle the virtualization and k8s-apps as well)
- 2 CPUs or more
- Network connection

Ensure that you have `docker` both client and version `1.13.x` or superior  

## Getting Started

To run the app, just:  

`./tanker`  

<p align="center">
  <img width="683" height="340" src="docs/imgs/wordpress.png">
</p>

It will run a kubernetes cluster under virtualbox driver and exposes the URL to be tested locally from a demonstration Wordpress application.  

The first execution can take some time due to the virtual machine creation.  

## Running my own apps

You don't have to stick to the default 'wordpress' example project, to deploy your own kubernetes' applications follow these steps:  

- create a dir located at `k8s-apps/` with the needed *.yamls
- add your app the list of apps (`KUBE_APPS`) located at `config/environment.sh`  
- run `./tanker` to create the new app  

Tanker will not give to you the exposed URL because it can vary due to specific configuration for you services. To check by yourself:  

`minikube service ${MY_SERVICE_NAME} --url`  

## Exposing Kubernetes Dashboard

By the default, the kubernetes dashboard will be exposed to the host as `localhost:3000` to simplify the usage. To disable this option just set `EXPOSE_DASHBOARD` environment variable as false at `config/environment.sh`  

## Security

It's highly recommended that **you do not** use tanker in production environments. The purpose of this project is to setup a development environment the quickest way possible. After that the deployment of your POC must be done with a secure Kubernetes Cluster using one of the following tools: `kops`, `kubeadm` or similar   

## Troubleshooting  

In order to run the app and follow line by line what happened, just set the environment variable `DEBUG` located at `config/environment.sh` as true. The next `./tanker` will output what is going on *under the hood*  

To wipe every minikube data due any additional problems when creating/running the cluster you can:

```
$ minikube stop # if started
$ minikube delete
$ rm -rf ~/.minikube
```

Then you can ask `./tanker` to create it again

## Why not 'kvm' driver?

The minikube driver (for virtual machines) `kvm` have multiple settings for several different distributions which could be impractical to maintain. Using the 'virtualbox' one instead can add one more level of flexibility in the future when `tanker` became "runnable" to multiple Linux distributions.

## Why not kubeadm?

You must be wondering why the project just not use `kubeadm` to install a real cluster instead of a virtual one using `minikube`. The `kubeadm` may need some additional intrusive configurations such as kernel configurations and network changes which could break any other part of the system if used in a dev machine instead of a server. To keep it simple, the `minikube` handles the situation. 

## Next steps

The project is still under development, and it needs to handle a few things for the future:  

- We are working with the possibility to run the app in a `sandbox-mode`, which is basically run it in a specific VM using Vagrant
