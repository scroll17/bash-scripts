containers=$(sudo docker ps -a -q)
sudo docker kill $containers
sudo docker rm $containers
