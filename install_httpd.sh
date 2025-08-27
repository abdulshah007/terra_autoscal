#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start
echo "<h1>Thank you all for showing interest in this session</h1>" | sudo tee /var/www/html/index.html
