FROM node:18-alpine AS deps
WORKDIR /opt/app
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev
COPY package.json yarn.lock ./
RUN yarn global add node-gyp
RUN yarn config set network-timeout 600000 -g && yarn install
ENV PATH /opt/app/node_modules/.bin:$PATH

FROM node:18-alpine AS builder
WORKDIR /opt/app
COPY . .
COPY --from=deps /opt/app/node_modules ./node_modules
RUN yarn build

FROM node:18-alpine AS runner
WORKDIR /opt/app

ENV NODE_ENV=production

COPY --from=builder /opt/app/dist ./dist
COPY --from=builder /opt/app/.env ./.env
COPY --from=builder /opt/app/public ./public
COPY --from=builder /opt/app/node_modules ./node_modules
COPY --from=builder /opt/app/package.json ./package.json

ENV PORT=1337
EXPOSE 1337

CMD ["yarn", "start"]
