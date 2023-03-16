FROM node:12-alpine3.9

COPY . .

RUN npm install --production

CMD ["node", "src/index.js"]