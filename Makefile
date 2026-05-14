init:
	k3d cluster create --config k3d/config.yaml
delete:
	k3d cluster delete Homelab
