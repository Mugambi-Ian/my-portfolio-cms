docker rm portfolio-cms
docker rmi portfolio-cms
docker build -t portfolio-cms . --network="host"
docker run -t -i -p 1337:443 portfolio-cms
