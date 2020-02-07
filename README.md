# Elastic cluster in Docker Swarm

1. Change user/password in docker-stack-elastic.yml,  (elastic/elastic used by default).

2. Add labels to target nodes:
```
    docker node update --label-add rabbitmq01=true node-1-name
    docker node update --label-add rabbitmq02=true node-2-name
    docker node update --label-add rabbitmq03=true node-3-name
```

3. Run
```
    make up
```

4. Check status
```
    make status
```

5. Connect to any node in swarm
```
    amqp://user:password@node-ip
    http://node-ip:15672/
```

5. Stop
```
    make down
```

6. Test
```
    docker run -it --rm pivotalrabbitmq/perf-test:latest --uri amqp://user:password@node-ip
```
