FROM node:14-alpine

WORKDIR /nodeapp

COPY package*.json ./

RUN NODE_ENV=development npm i

COPY . .

RUN npm run build

EXPOSE 80

CMD ["npm", "run", "dev"]