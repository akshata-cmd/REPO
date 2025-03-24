#!/bin/bash

echo "============== CREATE USERS ==============="

read -p "Enter the username: " username
read -p "Enter the password: " password

# this is creating a user
sudo useradd -m $username

# this is setting the password
echo -e "$password\n$password" | sudo passwd $username

echo "============== USERS CREATED ==============="
