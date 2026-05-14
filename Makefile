init:
	k3d cluster create --config k3d/config.yaml -p "8080:80@loadbalancer"
	helm install flux-operator oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator \
	  --namespace flux-system \
	  --create-namespace
	kubectl apply -f flux-instance.yaml

forward:
	kubectl port-forward --address 0.0.0.0 svc/donetick 2021

delete:
	k3d cluster delete Homelab
