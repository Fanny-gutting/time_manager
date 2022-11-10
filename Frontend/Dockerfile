FROM node:lts-alpine

RUN npm install -g http-server
WORKDIR /Frontend
COPY . ./

RUN npm install
RUN npm run build
# COPY package*.json ./

EXPOSE 8080
CMD [ "http-server", "dist" ]
# CMD ["npm", "run", "dev"]
