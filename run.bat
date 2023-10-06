docker rm "portfolio.cms" -f
docker rmi "portfolio.cms" -f
COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose build
docker run -d --name "portfolio.cms" --network portfolio-network -i -t -p 1337:1337 portfolio.cms
