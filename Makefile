up:
	sysctl -w vm.max_map_count=262144
	docker network inspect communicate-network > /dev/null || docker network create --driver=overlay communicate-network
	docker network inspect elastic > /dev/null || docker network create --driver=overlay elastic
	docker stack deploy -c docker-stack-elk.yml elk

down:
	docker stack rm elk

status:
	docker stack ps elk

migrate:
	bash migrate-index.sh
