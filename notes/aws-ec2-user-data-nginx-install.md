# AWWS User Data with nginx auto install
This [user data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html) code snippet will install nginx on first boot and create a html file with "Ready" in the web root of nginx.

This can also be used in launch template.

```
#!/bin/bash
yum update -y
amazon-linux-extras install -y nginx1.12
systemctl start nginx
systemctl enable nginx
usermod -a -G nginx-user ec2-user
chown -R ec2-user:nginx-user /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
echo "Ready" > /usr/share/nginx/html/index.html
