# ✅ Node.js Todo List – Dockerized & Automated Deployment

A complete walkthrough of deploying a Node.js Todo App using **Docker**, **MongoDB Atlas**, **Ansible**, and **Watchtower** for auto-updates.

---

🔹 **1. Clone and Run App**  
You cloned the Node.js todo-list app and successfully ran it.

🖼️ *(Add a screenshot of your app running locally)*

---

🔹 **2. Connect MongoDB**  
You connected it with your MongoDB Atlas database using a `.env` file:


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
🔹 **5. Set up Ubuntu VM**
And Getting IP address to connect them:
```
<img width="814" height="217" alt="image" src="https://github.com/user-attachments/assets/1524775c-4d5a-4ed8-bd0c-6290832266ac" />
```
