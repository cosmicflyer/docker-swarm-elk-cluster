up:
	sysctl -w vm.max_map_count=262144
	docker network inspect elastic-backend > /dev/null || docker network create --driver=overlay elastic-backend
	docker network inspect elastic-frontend > /dev/null || docker network create --driver=overlay elastic-frontend
	docker stack deploy -c docker-stack-elk.yml elk

down:
	docker stack rm elk

status:
	docker stack ps elk
	docker stack services elk

migrate:
	bash migrate-index.sh
