NAME := k8s-homelab
MINIKUBE := minikube
KUBECTL := kubectl

start:
	@echo "Starting local cluster..."
	$(MINIKUBE) start -p $(NAME) --memory=2912 --cpus=4 --driver=docker

start-argocd:
	@echo "Staring argocd"
	$(KUBECTL) port-forward svc/argocd-server -n argocd 8080:80

tunnel:
	@echo "Starting tunnel..."
	$(MINIKUBE) tunnel

stop:
	@echo "Stopping local cluster..."
	$(MINIKUBE) start -p $(NAME)

get-argocd-password:
	kubectl get secret argocd-initial-admin-secret \
  	-n argocd \
  	-o jsonpath="{.data.password}" | base64 --decode && echo