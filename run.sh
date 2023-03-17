docker rm portfolio-cms -f
docker rmi portfolio-cms -f
docker build -t portfolio-cms . --network="host"
docker run -t -i -p 1337:443 portfolio-cms
