FROM node:lts-alpine3.18 AS BUILD_IMAGE

RUN apk update && apk add yarn curl bash make && rm -rf /var/cache/apk/*

RUN curl -sf https://gobinaries.com/tj/node-prune | sh

WORKDIR /usr/src/app

COPY . .
RUN npm install --frozen-lockfile
RUN npx prisma generate
RUN npm run build

RUN npm prune --production

RUN /usr/local/bin/node-prune

FROM node:lts-alpine3.18

USER node
RUN mkdir -p /home/node/app/
RUN mkdir -p /home/node/app/node_modules
RUN mkdir -p /home/node/app/dist

RUN chown -R node:node /home/node/app
RUN chown -R node:node /home/node/app/node_modules
RUN chown -R node:node /home/node/app/dist

WORKDIR /home/node/app

# uncommand if want deploy without ci/cd in gcp
# COPY --from=BUILD_IMAGE /usr/src/app/.env /home/node/app/.env
COPY --from=BUILD_IMAGE /usr/src/app/dist /home/node/app/dist
COPY --from=BUILD_IMAGE /usr/src/app/node_modules /home/node/app/node_modules

EXPOSE 3000
CMD ["node", "/home/node/app/dist/main.js"]
