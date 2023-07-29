#!/bin/bash

### Install jenkins ###

yum update –y
wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade
amazon-linux-extras install java-openjdk11 -y
yum install jenkins git -y

wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin credentials-binding
java -jar jenkins-cli.jar -s http://localhost:8080/ safe-restart

### Install Docker and start Docker, Jenkins ###

yum install -y docker
usermod -aG docker jenkins
service docker start
service jenkins start

### Instal kind, kubectl ###

[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

### Cluster config ###
echo 'apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30000
    hostPort: 30000
    listenAddress: "0.0.0.0" # Optional, defaults to "0.0.0.0"
    protocol: tcp # Optional, defaults to tcp' > /var/lib/jenkins/kind.yaml

### Create kind cluster ###
kind create cluster --config=/var/lib/jenkins/kind.yaml

### Configure kubctl jenkins
mkdir -p /var/lib/jenkins/.kube/
kind get kubeconfig --name=kind > /var/lib/jenkins/.kube/config 
chown -R jenkins: /var/lib/jenkins/.kube/

#chmod +x kubectl
#mkdir -p ~/.local/bin
#mv ./kubectl ~/.local/bin/kubectl

### Install Helm ###

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


##### Build Fask-app and push it to ECR ###
#docker build -t flask:v1 Flask-app
#aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin "$(aws ecr describe-repositories --region eu-central-1 --repository-names flask --query 'repositories[0].repositoryUri' --output text)"
#docker tag flask:v1 $(aws ecr describe-repositories --repository-names flask --query 'repositories[0].repositoryUri' --output text --region eu-central-1):latest
#docker push $(aws ecr describe-repositories --repository-names flask --query 'repositories[0].repositoryUri' --output text --region eu-central-1):latest