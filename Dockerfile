FROM ubuntu:22.04 AS deps
WORKDIR /opt/app
RUN apt update && apt add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev
COPY package.json yarn.lock ./
RUN yarn

FROM ubuntu:22.04 AS builder
WORKDIR /opt/app
COPY . .
COPY --from=deps /opt/app/node_modules ./node_modules
RUN yarn build

FROM ubuntu:22.04 AS runner
WORKDIR /opt/app

ENV NODE_ENV=production

COPY --from=builder /opt/app/dist ./dist
COPY --from=builder /opt/app/.env ./.env
COPY --from=builder /opt/app/public ./public
COPY --from=builder /opt/app/node_modules ./node_modules
COPY --from=builder /opt/app/package.json ./package.json
ENV PATH --from=builder /opt/node_modules/.bin:$PATH


ENV PORT=1337
EXPOSE 1337

CMD ["yarn", "start"]
