FROM node:18

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the app
COPY . .

# Expose the port the app runs on
EXPOSE 4000

# Command to run the app
CMD ["npm", "start"]
