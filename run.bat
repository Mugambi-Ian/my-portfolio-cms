docker rm portfolio-cms -f
docker rmi portfolio-cms -f
docker build -t portfolio-cms . --network="host"
docker run -d --name "portfolio-cms"  -i -t -p 1337:1337 portfolio-cms
