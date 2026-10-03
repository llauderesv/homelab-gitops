NAME := k8s-homelab
MINIKUBE := minikube
KUBECTL := kubectl
ISTIO_INGRESS_LOCAL_PORT ?= 8080

start:
	@echo "Starting local cluster..."
	$(MINIKUBE) start -p $(NAME) --memory=10240 --cpus=4 --driver=docker

start-argocd:
	@echo "Staring argocd"
	$(MINIKUBE) service argocd-server -n argocd

start-istio-ingressgateway:
	@echo "Forwarding localhost:$(ISTIO_INGRESS_LOCAL_PORT) to the Istio ingress gateway (Ctrl+C to stop)"
	$(KUBECTL) --context=$(NAME) -n istio-system port-forward svc/istio-ingressgateway $(ISTIO_INGRESS_LOCAL_PORT):80

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
