#!/bin/bash
docker service create --name meu-app --replicas 15 -dt -p 8080:80 --mount type=volume,src=app,dst=/usr/local/apache2/htdocs/ httpd
