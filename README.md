# Elastic cluster in Docker Swarm

1. Change user/password in docker-stack-elastic.yml, configs/kibana.yml (elastic/elastic used by default).

2. Add labels to target nodes:
```
    docker node update --label-add elastic01=true node-1-name
    docker node update --label-add elastic02=true node-2-name
    docker node update --label-add elastic03=true node-3-name
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
    elasicsearch: http://user:password@node-ip:9200
    kibana: http://node-ip:5601/
```

6. Stop
```
    make down
```

7. Check cluster and indexes
```
    curl -sb -X GET "http://user:password@node-ip:9200/_cat/health?v"
    curl -sb -X GET "http://user:password@node-ip:9200/_cat/nodes?v"
    curl -sb -X GET "http://user:password@node-ip:9200/_cat/indices?v"

```

8. If you need copy indexes from other elastic servers

  - Change user/password/ip/port of old and new clusters in migrate-index.sh (string 5, 6, 15, 16)
  - Add "reindex.remote.whitelist: old_server_ip:old_server:port" to configs/elasticsearch.yml
  - Run 
    ```
    make down
    make up
    make migrate
    ```
 
