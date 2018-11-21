FROM node:10.13.0-alpine

WORKDIR /parse

COPY package.json /parse

RUN apk add --no-cache build-base make gcc g++ python krb5-dev

RUN npm install

COPY . /parse

EXPOSE 3000

# Uncomment if you want to access cloud code outside of your container
# A main.js file must be present, if not Parse will not start

VOLUME /parse/cloud               

CMD [ "npm", "start" ]