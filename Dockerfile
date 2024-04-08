FROM node:lts AS BUILD_IMAGE

WORKDIR /app

COPY . /app

RUN npm i && npm run build

FROM node:lts-alpine

COPY --from=BUILD_IMAGE /app/configs ./configs
COPY --from=BUILD_IMAGE /app/package.json ./package.json
COPY --from=BUILD_IMAGE /app/dist ./dist
COPY --from=BUILD_IMAGE /app/node_modules ./node_modules

WORKDIR /app
ENV PORT 3000
EXPOSE $PORT

CMD npm run start -- -p $PORT
