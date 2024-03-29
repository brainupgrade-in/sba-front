### STAGE 1: Build ###
FROM node:13.12.0-alpine AS build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:stable-alpine
# COPY nginx-multi.conf /etc/nginx/nginx.conf
COPY --from=build /app/build /usr/share/nginx/html

# docker build -f Dockerfile -t brainupgrade/sba-frontend:1.0.0 . 
# docker run -d -p 80:80 --link apiserver:apiserver  brainupgrade/sba-frontend:1.0.0