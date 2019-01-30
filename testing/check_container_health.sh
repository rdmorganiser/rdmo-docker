#!/bin/bash

max=30

while (( c<${max} )); do
    c=$((c+1))
    docker ps | grep "(healthy)" \
        && echo "Container is healthy" \
        && exit 0
    sleep 2
done

echo "Container health check failed"
exit 1
