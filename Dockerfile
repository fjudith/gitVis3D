FROM amd64/node:lts-alpine

LABEL maintainer="Florian JUDITH <florian.judith.b@gmail.com>"

RUN mkdir -p /home/node/gitvis3d

WORKDIR /home/node/gitvis3d

ADD public8080 /home/node/gitvis3d/public8080
ADD routes /home/node/gitvis3d/routes
ADD views /home/node/gitvis3d/views
ADD cypherVis3DWebServer8080.js /home/node/gitvis3d/
ADD githubAPIServer3000.js /home/node/gitvis3d/
ADD gitlogConvertToNeo4jData.py /home/node/gitvis3d/

RUN npm install express --save && \
    npm install \
    ejs \
    github-api \
    neo4j-driver \
    body-parser \
    socket.io \
    seraph \
    npm dedup

ADD docker-entrypoint.sh /home/node/gitvis3d/docker-entrypoint.sh
RUN chown -R node:node /home/node/gitvis3d/docker-entrypoint.sh
RUN chmod +x /home/node/gitvis3d/docker-entrypoint.sh

RUN chown -R node:node /home/node/gitvis3d

USER node

ENV NODE_DEBUG=${NODE_DEBUG:-'cluster,net,http,fs,tls,module,timers,socket.io,express,github-api'}
ENV NODE_ENV=${NODE_ENV:-'production'}

ENTRYPOINT [ "/home/node/gitvis3d/docker-entrypoint.sh" ]
CMD ["node"]