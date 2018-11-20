FROM node:10

RUN mkdir parse

ADD . /parse
WORKDIR /parse
RUN npm install

ENV APP_ID=gbts-5sp5m6ncszz
ENV MASTER_KEY=tWT9d9FaBvqawa3d
ENV JAVASCRIPT_KEY=VQ8z4AYafxJXdvYA
ENV REST_API_KEY=mBWbk7k3SrEWyEVJ
ENV CLIENT_KEY=LwAg2ckKZpFNuvYY

# Optional (default : 'parse/cloud/main.js')
# ENV CLOUD_CODE_MAIN cloudCodePath

# Optional (default : '/parse')
ENV PARSE_MOUNT mountPath

EXPOSE 1337

# Uncomment if you want to access cloud code outside of your container
# A main.js file must be present, if not Parse will not start

VOLUME /parse/cloud               

CMD [ "npm", "start" ]
