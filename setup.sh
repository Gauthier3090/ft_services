#!/bin/bash

YELLOW="\e[33m"
GREEN="\e[32m"
NOCOLOR="\e[0m"

install_minikube()
{
	if ! [ -x "$(command -v minikube)" ]; then
		echo ${YELLOW}"[INFO]"${NOCOLOR}" installing minikube..."
		curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
		&& chmod +x minikube
		sudo mv minikube /usr/local/bin/
		echo ${YELLOW}"[INFO]"${NOCOLOR}" minikube is installed ! "${GREEN}"[OK]"${NOCOLOR}
	else
		echo ${YELLOW}"[INFO]"${NOCOLOR}" minikube is already installed ! ✔️"
	fi
}

install_kubectl()
{
	if ! [ -x "$(command -v kubectl)" ]; then
		curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
		&& chmod +x ./kubectl
		sudo mv ./kubectl /usr/local/bin/
		echo ${YELLOW}"[INFO]"${NOCOLOR}" kubectl is installed ! "${GREEN}"[OK]"${NOCOLOR}
	else
		echo ${YELLOW}"[INFO]"${NOCOLOR}" kubectl is already installed ! ✔️"
	fi
}

install_metallb()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/namespace.yaml > /dev/null
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.4/manifests/metallb.yaml > /dev/null
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
	kubectl apply -f srcs/metallb/metallb-config.yaml > /dev/null
}

deploy_docker()
{
	docker build -t nginx ./srcs/nginx;
}

deploy_yaml()
{
	kubectl apply -f ./srcs/nginx/nginx.yaml > /dev/null
}

launch_minikube()
{
	minikube start --vm-driver=virtualbox --memory='2000' --disk-size 5000mb;
	minikube addons enable dashboard;
	minikube addons enable metrics-server;
	eval $(minikube docker-env)
	install_metallb
	deploy_docker
	deploy_yaml
	minikube dashboard
}

install_minikube
install_kubectl
launch_minikube
