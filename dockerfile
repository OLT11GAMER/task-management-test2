FROM node:14-alpine

WORKDIR /nodeapp

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 80

CMD ["npm", "run", "dev"]