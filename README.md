# ✅ Node.js Todo List – Dockerized & Automated Deployment

A complete walkthrough of deploying a Node.js Todo App using **Docker**, **MongoDB Atlas**, **Ansible**, and **Watchtower** for auto-updates.

---

🔹 **1. Clone and Run App**  
Cloned the Node.js todo-list app and successfully ran it.

---

🔹 **2. Connect MongoDB**  
Connected it with your MongoDB Atlas database using a `.env` file:


🔹 **3. Created a Dockerfile and .dockerignore**
Then ran it with to build:
```
docker build -t todo-app .
docker run -p 4000:4000 --env-file .env todo-app
```
🔹 **4. Pushed Image to Docker Hub**
```
docker tag todo-app nardymichelle2003/todo-app
docker push nardymichelle2003/todo-app
```
<img width="1896" height="959" alt="Screenshot 2025-07-27 004441" src="https://github.com/user-attachments/assets/ae6d0552-b538-4a0a-bb88-2e2954fb78ba" />

🔹 **5. Set up Ubuntu VM**
Getting IP address to connect them:

<img width="814" height="217" alt="image" src="https://github.com/user-attachments/assets/2146f473-831b-4d8d-a228-d995d9a235eb" />

🔹 **6. Install Ansible on Host**
Installed Ansible in WSL and ran it inside the /mnt/c/Windows/system32/ansible-docker-setup
inventory.ini
```
ansible-playbook -i inventory.ini install-docker.yml
```
install-docker.yml
```
 ---
- name: Install Docker on Ubuntu VM   # Playbook name (shows in Ansible output)
  hosts: ubuntu_vm                   # Target host group (from inventory.ini)
  become: true                        # Run tasks with sudo privileges

  tasks:
    - name: Update apt cache
      apt:
        update_cache: yes             # Refresh package lists

    - name: Install required packages # Prerequisites for Docker repo
      apt:
        name:
          - apt-transport-https       # Allows APT to use HTTPS for repos
          - ca-certificates           # Ensures SSL certificates are valid
          - curl                      # Downloads Docker's GPG key
          - software-properties-common # Lets you add external APT repos
        state: present

    - name: Add Docker GPG key
      apt_key:
        url: https://download.docker.com/linux/ubuntu/gpg
        state: present                 # Ensures the key is installed

    - name: Add Docker repository
      apt_repository:
        repo: deb https://download.docker.com/linux/ubuntu focal stable
        state: present

    - name: Install Docker
      apt:
        name: docker-ce               # Installs the latest Docker Engine
        state: latest
        update_cache: yes

    - name: Enable and start Docker
      service:
        name: docker
        state: started                 # Starts Docker immediately
        enabled: yes                   # Ensures Docker starts on boot


```
🔹 **7. Run Docker Image in VM**
Pulled and ran your Docker image on the VM:
```
docker run -d -p 4000:4000 --env-file .env nardymichelle2003/todo-app
```

🔹 **10. Docker Compose + Health Checks**
Created a docker-compose.yml with health checks like:
```
services:
  todo-app:
    image: nardymichelle2003/todo-app
    ports:
      - "4000:4000"
    env_file:
      - .env
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:4000"]
      interval: 30s
      timeout: 10s
      retries: 3
```
Ran it using 
```
docker compose up -d
```
<img width="1243" height="186" alt="Screenshot 2025-07-28 012727" src="https://github.com/user-attachments/assets/205696e3-cb82-4cd5-8217-72abe20b4e52" />

🔹 **11. Auto-Update with Watchtower**
Installed Watchtower to auto-pull new image versions
```
docker run -d \
  --name watchtower \
  --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --interval 30 \
  todo-app

```
<img width="742" height="345" alt="Screenshot 2025-07-28 012047" src="https://github.com/user-attachments/assets/cdd05bcc-4d3e-42cd-8a69-a4c907e6b4fd" />

Why Watchtower?
It checks Docker Hub for updated images and automatically restarts containers with the new version, minimal setup,and easy to use.
What Are they other Options?
- Diun Notifies you when a new image is available (does not auto-restart the container by default).
- Jenkins + Webhook or Cron too advanced and requires alot of setup Jenkins and pipelines
- Webhook Trigger complex setup as well
--------------------------------------
Dockerhub link
https://hub.docker.com/repository/docker/nardymichelle2003/todo-app/general
