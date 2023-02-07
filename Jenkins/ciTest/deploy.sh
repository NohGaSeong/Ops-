#!/bin/bash

docker pull 950633267104.dkr.ecr.ap-northeast-2.amazonaws.com/test:latest
docker run --name test-django -d -p 8000:8000