NAME := k8s-homelab
MINIKUBE := minikube

start:
	@echo "Starting local cluster..."
	$(MINIKUBE) start -p $(NAME) --memory=2912 --cpus=4 --driver=docker