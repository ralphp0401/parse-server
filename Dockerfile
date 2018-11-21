FROM node:10.13-alpine

WORKDIR /parse

COPY package.json /parse

RUN apk add --no-cache make gcc g++ python

RUN npm install --prod

COPY . /parse

ENV APP_ID=evol-5sp5m6ncszz
ENV MASTER_KEY=tWT9d9FaBvqawa3d
ENV JAVASCRIPT_KEY=VQ8z4AYafxJXdvYA
ENV REST_API_KEY=mBWbk7k3SrEWyEVJ
ENV CLIENT_KEY=LwAg2ckKZpFNuvYY
ENV SERVER_URL=http://localhost:3000/parse
ENV PORT=3000
ENV DATABASE_URI=mongodb://localhost:27017/evolussion
# Optional (default : 'parse/cloud/main.js')
# ENV CLOUD_CODE_MAIN cloudCodePath

# Optional (default : '/parse')
# ENV PARSE_MOUNT mountPath

EXPOSE 3000


# Uncomment if you want to access cloud code outside of your container
# A main.js file must be present, if not Parse will not start

VOLUME /parse/cloud               

CMD [ "npm", "start" ]
