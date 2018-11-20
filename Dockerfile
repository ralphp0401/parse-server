FROM node:10

WORKDIR /parse

COPY package.json /parse

RUN echo "registry=http://registry.npmjs.org/\nstrict-ssl=false\nhttps-proxy=http://x219827:vacano04@internetproxy.prudential.com:8080\nproxy=http://x219827:vacano04@internetproxy.prudential.com:8080\n" > .npmrc

RUN npm install --only=production

COPY . /parse

ENV APP_ID=gbts-5sp5m6ncszz
ENV MASTER_KEY=tWT9d9FaBvqawa3d
ENV JAVASCRIPT_KEY=VQ8z4AYafxJXdvYA
ENV REST_API_KEY=mBWbk7k3SrEWyEVJ
ENV CLIENT_KEY=LwAg2ckKZpFNuvYY
ENV PORT=3000

# Optional (default : 'parse/cloud/main.js')
# ENV CLOUD_CODE_MAIN cloudCodePath

# Optional (default : '/parse')
# ENV PARSE_MOUNT mountPath

EXPOSE 3000
RUN export DOCKER_HOST_IP=$(route -n | awk '/UG[ \t]/{print $2}')

# Uncomment if you want to access cloud code outside of your container
# A main.js file must be present, if not Parse will not start

VOLUME /parse/cloud               

CMD [ "npm", "start" ]
