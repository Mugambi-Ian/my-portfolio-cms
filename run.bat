docker rm "portfolio.cms" -f
docker rmi "portfolio.cms" -f
docker-compose build
docker run -d --network portfolio-network -i -t -p 172.18.0.1:1337:1337 portfolio.cms
