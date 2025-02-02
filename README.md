This document provides a step-by-step process on how to use the Terraform configuration for setting up an Amazon EKS (Elastic Kubernetes Service) cluster. provided steps will help you clone the repository, configure your environment, and deploy the cluster.


Prerequisites
Before you proceed, ensure that you have the following tools installed and configured:

AWS CLI: To interact with your AWS account.
Terraform: To deploy infrastructure as code.

AWS CLI Configuration
Install AWS CLI on your system. 
Configure your AWS CLI with valid credentials using the following command:

"aws configure"

You'll require your AWS Access Key ID, AWS Secret Access Key, and Default region name.

Terraform Installation
If you don’t have Terraform installed yet, you can install it as per your operatingsystem



Steps to Use the Terraform Code

1. Clone the GitHub Repository

2. https://github.com/Ramprasadvaral13/Project-Atc.git

3. cd Terraform

4. Initialize Terraform:

5. Terraform init

6. Terraform plan

7. Terraform apply

Configure kubectl:

aws eks --region <region> update-kubeconfig --name <cluster-name>

 Verify the Cluster:
 kubectl get nodes or kubectl get pods -A

 once the cluster is created you need to create the namespace called "demo-ns" using the command below

 kubectl create ns demo-ns

 once you create the namespace you need to switch to the namespace by using the below command

 kubectl config set-context --current  --namespace=demo-ns

 you can verify if the namespace has changed or not by the below command

kubectl config view | grep namespace

once this is done you can come out of the Terraform directory usinf the cd command

cd ..

now you can run the below command

kubectl apply -f deployment.yaml this will create a sigle pod on your node

you can verify this using the command
kubectl get pods

after this you need to run the command kubectl apply -f svc.yaml

this will create a service type of LoadBalncer this loadbalancer is created in Aws as we are using Aws EKS

once this is done you can run the command kubectl get svc this command provides you the ExternalIP by which you can access the static website.

**Monitoring**

For Monitoring I have used Prometheus and Grafana

First You need to install the helm, Helm is a package manager for Kubernetes, an open-source container orchestration platform. Helm helps you manage Kubernetes applications by making it easy to install, update, and delete them. Use the below script to install helm

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

verify with below command 

helm version

once this is done We need to add the Helm Stable Charts for your local client.
helm repo add stable https://charts.helm.sh/stable

Add Prometheus Helm repo:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

Create Prometheus namespace:
kubectl create namespace prometheus

Install Prometheus:
helm install stable prometheus-community/kube-prometheus-stack -n prometheus

To check whether Prometheus is installed or not use the below command
kubectl get pods -n prometheus

to check the services file (svc) of the Prometheus
kubectl get svc -n prometheus

let’s expose Prometheus and Grafana to the external world using LoadBalncer method

to attach the load balancer we need to change from ClusterIP to LoadBalancer
below is the command to get the svc file
kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus

change it from ClusterIP to LoadBalancer after changing make sure you save the file
kubectl get svc -n prometheus

now we have a load balancer for Prometheus which can access from that link port 9090

now we can change the SVC file of the Grafana and expose it to the outer world
kubectl edit svc stable-grafana -n prometheus

kubectl get svc -n prometheus

use the link of the LoadBalancer and access from the Browser

use the below command to get the password
the user name is admin
kubectl get secret --namespace prometheus stable-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo



