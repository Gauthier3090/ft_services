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
		echo ${YELLOW}"[INFO]"${NOCOLOR}" installing kubectl..."
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
	if [ "$(kubectl get secrets --namespace metallb-system | grep memberlist)" = "" ]; then
        kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
    fi
	kubectl apply -f srcs/metallb/metallb-config.yaml > /dev/null
}

deploy_docker()
{
	echo "🐳  Build nginx ..."
	docker build -t nginx ./srcs/nginx > /dev/null

	echo "🐳  Build mysql ..."
	docker build -t mysql ./srcs/mysql > /dev/null

	echo "🐳  Build phpmyadmin ..."
	docker build -t phpmyadmin ./srcs/phpmyadmin > /dev/null

	echo "🐳  Build wordpress ..."
	docker build -t wordpress ./srcs/wordpress > /dev/null

	echo "🐳  Build ftps ..."
	docker build -t ftps ./srcs/ftps > /dev/null

	echo "🐳  Build influxdb ..."
	docker build -t influxdb ./srcs/influxdb > /dev/null

	echo "🐳  Build grafana ..."
	docker build -t grafana ./srcs/grafana > /dev/null

	echo "🐳  Build telegraf ..."
	docker build -t telegraf ./srcs/telegraf > /dev/null
	
	echo "👍  All images are build ! "
}

deploy_yaml()
{
	echo "🚀  Deploy nginx ..."
	kubectl apply -f ./srcs/nginx/nginx.yaml > /dev/null

	echo "🚀  Deploy mysql ..."
	kubectl apply -f ./srcs/mysql/mysql.yaml > /dev/null

	echo "🚀  Deploy phpmyadmin ..."
	kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml > /dev/null

	echo "🚀  Deploy wordpress ..."
	kubectl apply -f ./srcs/wordpress/wordpress.yaml > /dev/null

	echo "🚀  Deploy ftps ..."
	kubectl apply -f ./srcs/ftps/ftps.yaml > /dev/null

	echo "🚀  Deploy influxdb ..."
	kubectl apply -f ./srcs/influxdb/influxdb.yaml > /dev/null

	echo "🚀  Deploy grafana ..."
	kubectl apply -f ./srcs/grafana/grafana.yaml > /dev/null

	echo "🚀  Deploy telegraf ..."
	kubectl apply -f ./srcs/telegraf/telegraf.yaml > /dev/null

	echo "👍  All .yaml files are deployed ! "
}

launch_minikube()
{
	minikube start --vm-driver=virtualbox
	minikube addons enable metrics-server
	eval $(minikube docker-env)
	install_metallb
	deploy_docker
	deploy_yaml
	minikube dashboard
}

install_minikube
install_kubectl
launch_minikube
