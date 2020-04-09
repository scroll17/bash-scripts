containers=$(sudo docker ps -a -q)
echo 'stop'
sudo docker stop $containers
echo 'rm'
sudo docker rm $containers
