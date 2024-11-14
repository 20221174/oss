# 1. set base image 
FROM node:16

# 2. make app directory
WORKDIR /app

# 3. copy dependancy
COPY package*.json ./

# 4. install dependency
RUN npm install

# 5. copy server.js
COPY index.js .

# 6. port
EXPOSE 5001

# 7. run app
CMD ["node", "index.js"]

