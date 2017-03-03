#!/bin/bash
docker push jahongirr/sample-node

ssh deploy@159.203.127.59 << EOF
docker pull jahongirr/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi jahongirr/sample-node:current || true
docker tag jahongirr/sample-node:latest jahongirr/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 jahongirr/sample-node:current
EOF
