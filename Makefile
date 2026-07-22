init:
	k3d cluster create --config k3d/config.yaml -p "8080:80@loadbalancer" -p "32021:32021@server:0"
	helm install flux-operator oci://ghcr.io/controlplaneio-fluxcd/charts/flux-operator \
	  --namespace flux-system \
	  --create-namespace
	kubectl apply -f flux-instance.yaml

forward:
	kubectl port-forward --address 0.0.0.0 svc/donetick 2021 &
	kubectl port-forward --address 0.0.0.0 svc/nextcloud 8081:8080 -n nextcloud

delete:
	k3d cluster delete Homelab

backup:
	@read -p "Pod name: " POD; \
	echo $$POD; \
	kubectl cp $$POD:/donetick-data /data
