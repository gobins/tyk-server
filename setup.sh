sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org redis-server vim curl

curl -s https://packagecloud.io/install/repositories/tyk/tyk-gateway/script.deb.sh | sudo bash
curl -s https://packagecloud.io/install/repositories/tyk/tyk-dashboard/script.deb.sh | sudo bash

sudo apt-get install -y tyk-gateway tyk-dashboard

redis-cli config set requirepass password
sudo /opt/tyk-gateway/install/setup.sh --dashboard=1 --listenport=8080 --redishost=localhost --redisport=6379 --redis_password=password --domain="localhost" --mongo=mongodb://localhost/tyk_analytics
sudo /opt/tyk-dashboard/install/setup.sh --listenport=3000 --redishost=localhost --redis_password=password --redisport=6379 --mongo=mongodb://localhost/tyk_analytics --tyk_api_hostname=localhost --tyk_node_hostname=http://localhost --tyk_node_port=8080 --portal_root=/portal --domain="localhost"

sudo service tyk-gateway start
sudo service tyk-dashboard start