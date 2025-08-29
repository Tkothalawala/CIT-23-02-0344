CCS3308 – Virtualization and Containers – Assignment 1

 Student: Tharindu Kothalawala
 Registration No: CIT-23-02-0344
 Due Date: 15th August 2025
 Application Overview

Dear Sir,
Ubuntu was not worked in my personal laptop.So I do this assignment form my friend's laptop. He name is Dilshan kodithuwakku.(cit-23-02-0299).
Thank you.

This project is a containerized web application using Docker that includes:

    A simple Flask web app

    A PostgreSQL database

    A persistent Docker volume for data storage

    Docker network for container communication

This setup demonstrates a multi-service application using Docker, as required by Assignment 1.
📋 Features

✅ Two services (Flask + PostgreSQL)
✅ One named volume (myapp-db)
✅ Custom Docker network (myapp-net)
✅ Restart policy: on-failure
✅ Scripts to manage the lifecycle
✅ README and documentation
⚙️ System Requirements

    Ubuntu 20.04+ or 22.04+

    Docker Engine

    Docker Compose plugin (optional)

    Git

🧪 Installation (on Ubuntu)

First, install Docker (if not already done):

# 1. Install Docker dependencies
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# 2. Add Docker GPG key and repo
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 3. Install Docker Engine & Compose
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 4. Allow running docker without sudo
sudo usermod -aG docker $USER
newgrp docker

# 5. Confirm installation
docker version

🚀 Running the App

    Unzip the project:

unzip ccs3308-docker-app.zip
cd ccs3308-docker-app

    Make scripts executable (first time only):

chmod +x *.sh

    Prepare app (create volume/network, build image):

./prepare-app.sh

    Start containers:

./start-app.sh

    Access it in your browser at:

http://localhost:5000

    Stop the containers (keep data):

./stop-app.sh

    Remove everything (containers, volume, image, network):

./remove-app.sh

🗃️ Project Structure

ccs3308-docker-app/
├── flask-app/
│   ├── app.py
│   └── Dockerfile
├── prepare-app.sh
├── start-app.sh
├── stop-app.sh
├── remove-app.sh
├── docker-compose.yaml  (optional)
└── README.md

🧠 App Logic

    On visiting http://localhost:5000

    , a counter (stored in PostgreSQL) is incremented and shown.

    The visit count is stored in a persistent Docker volume myapp-db.

    Restarting the containers does not reset the counter.

🧪 Docker Details

🛠 Services:

    Flask web service (container: my-flask)

    PostgreSQL database (container: my-postgres)

📦 Volume:

    myapp-db (bound to /var/lib/postgresql/data)

🌐 Network:

    myapp-net (Docker bridge network)

🔁 Restart Policy:

    on-failure for both containers

🧰 Optional: Using Docker Compose

docker compose up -d       # Start
docker compose stop        # Stop containers (data remains)
docker compose down        # Remove containers only
docker compose down -v     # Remove everything including volume

📤 Submission

Push to GitHub like this:

git init
git add .
git commit -m "Assignment 1 submission"
git branch -M main
git remote add origin https://github.com/Tkothalawala/CIT-23-02-0344.git
git push -u origin main

Then submit the GitHub repo link to your LMS.
