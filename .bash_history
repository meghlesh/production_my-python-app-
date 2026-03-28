sudo yum update -y
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user
docker --version
mkdir my-python-app
ls
cd my-python-app
vi app.py
vi requirements.txt
vi Dockerfile
ls
docker build -t my-python-app .
sudo usermod -aG docker ec2-user
exit
