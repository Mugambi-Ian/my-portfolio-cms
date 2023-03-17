docker rm portfolio-cms -f
docker rmi portfolio-cms -f
docker build -t portfolio-cms . --network="host"
docker run -t -i -p 443:1337 portfolio-cms
