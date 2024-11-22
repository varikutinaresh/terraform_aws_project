#!/bin/bash

# Check if running on an EC2 instance
if curl -s http://169.254.169.254/latest/meta-data/instance-id > /dev/null; then
    echo "Running on an EC2 instance"
    INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
else
    echo "Not running on an EC2 instance. Skipping EC2 metadata retrieval."
    INSTANCE_ID="Local Machine"  # You can set this to something else as needed
fi

# Update the system and install Apache HTTP server
apt update -y
apt install -y apache2

# Install the AWS CLI
apt install -y awscli

# Create a simple HTML file with the portfolio content and instance ID
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    /* Add animation and styling for the text */
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 1</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to varikuti naresh terraform perform</p>
  
</body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2
