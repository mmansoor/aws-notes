#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install -y nginx1.12
sudo systemctl start nginx
sudo systemctl enable nginx
usermod -a -G nginx-user ec2-user
chown -R ec2-user:nginx-user /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` && curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/local-ipv4 > /usr/share/nginx/html/ready.html
sudo yum -y install ruby
cd /tmp
wget https://aws-codedeploy-us-east-2.s3.amazonaws.com/latest/install;
chmod +x ./install
./install auto
sudo service codedeploy-agent start
sudo systemctl enable codedeploy-agent.service
sudo yum install -y awslogs
sudo systemctl start awslogsd
sudo systemctl enable awslogsd.service
sudo amazon-linux-extras install python3
#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
#sudo yum -y install python-pip
sudo wget -r --no-parent -A 'epel-release-*.rpm' https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/
sudo rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm
sudo yum-config-manager --enable epel*
sudo yum repolist all
sudo yum install -y certbot python2-certbot-nginx
